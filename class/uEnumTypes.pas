unit uEnumTypes;

interface

type

  TOperationType = (otInsert, otUpdate, otDelete);
  TFormMode = (fmRegister, fmSearch);
  TSearchEntityType = (setCategory, setSubCategory, setCustomer, setProvider, setTypePayment, setFormPayment);
  TTypeMovement = (tmRevenues, tmExpenses);
  TMessageType = (mtSuccess, mtWarning, mtError, mtInformation);

implementation

end.
