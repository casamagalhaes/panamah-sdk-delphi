unit PanamahSDK.XMLUtils;

interface

uses
  SysUtils, Classes, msxmldom, XMLDoc, XMLIntf, xmldom;

type

  TCustomXMLNodeArray = array of IXMLNode;

  TPanamahXMLHelper = class
    public
      class function FindChildNode(const ANode: IXMLNode;
        const AName: string): IXMLNode;
      class function XPathValue(const ANode: IXMLNode;
        const XPath: string): string; overload;
      class function XPathValue(const ADocument: IXMLDocument;
        const XPath: string): string; overload;
      class function XPathSelect(const ANode: IXMLNode;
        const XPath: string): TCustomXMLNodeArray; overload;
      class function XPathSelect(const ADocument: IXMLDocument;
        const XPath: string): TCustomXMLNodeArray; overload;
      class function CreateDocument(const AXML: string): IXMLDocument;
  end;

const
  DOM_VENDOR = msxmldom.SMSXML;

implementation

{ TPanamahXMLHelper }

class function TPanamahXMLHelper.CreateDocument(
  const AXML: string): IXMLDocument;
var
  Document: TXMLDocument;
begin
  Document :=  TXMLDocument.Create(nil);
  Document.Options := [doNodeAutoCreate, doNodeAutoIndent, doAttrNull,
                     doAutoPrefix, doNamespaceDecl];
  Document.DOMVendor := GetDOMVendor(DOM_VENDOR);
  Document.LoadFromXML(AnsiToUtf8(AXML));
  Result := Document;
end;

class function TPanamahXMLHelper.FindChildNode(const ANode: IXMLNode;
  const AName: string): IXMLNode;
var
  ChildNode: IXMLNode;
  NodeIdx: Integer;
begin
  Result := nil;
  if ANode.HasChildNodes then
  begin
    for NodeIdx := 0 to ANode.ChildNodes.Count - 1 do
    begin
      ChildNode := ANode.ChildNodes[NodeIdx];
      if SameText(ChildNode.NodeName, AName) then
      begin
        Result := ChildNode;
        Exit;
      end;
    end;
  end;
end;

class function TPanamahXMLHelper.XPathSelect(const ANode: IXMLNode;
  const XPath: string): TCustomXMLNodeArray;
var
  DomNodeSelect: IDomNodeSelect;
  DOMNode      : IDOMNode;
  DocAccess    : IXmlDocumentAccess;
  Doc          : TXmlDocument;
  DOMNodes     : IDOMNodeList;
  DOMNodeIdx   : Integer;
begin
  SetLength(Result, 0);
  if Assigned(ANode) and
    Supports(ANode.DOMNode, IDomNodeSelect, DomNodeSelect) then
    DOMNodes := DomNodeSelect.SelectNodes(XPath);
  if not Assigned(DOMNodes) then
    Exit;
  SetLength(Result, DOMNodes.Length);
  for DOMNodeIdx := 0 to DOMNodes.Length - 1 do
  begin
    Doc := nil;
    DOMNode := DOMNodes.Item[DOMNodeIdx];
    if Supports(ANode.OwnerDocument, IXmlDocumentAccess, DocAccess) then
      Doc := DocAccess.DocumentObject;
    Result[DOMNodeIdx] := TXmlNode.Create(DOMNode, nil, Doc) as IXMLNode;
  end
end;

class function TPanamahXMLHelper.XPathSelect(const ADocument: IXMLDocument;
  const XPath: string): TCustomXMLNodeArray;
begin
  Result := TPanamahXMLHelper.XPathSelect(ADocument.DocumentElement, XPath);
end;

class function TPanamahXMLHelper.XPathValue(const ADocument: IXMLDocument;
  const XPath: string): string;
begin
  Result := TPanamahXMLHelper.XPathValue(ADocument.DocumentElement, XPath);
end;

class function TPanamahXMLHelper.XPathValue(const ANode: IXMLNode;
  const XPath: string): string;
var
  Nodes: TCustomXMLNodeArray;
begin
  Result := EmptyStr;
  Nodes := XPathSelect(ANode, XPath);
  if Length(Nodes) > 0 then
    Result := Nodes[0].Text;
end;

initialization
  DefaultDOMVendor := DOM_VENDOR;

end.
