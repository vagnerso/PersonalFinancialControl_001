unit uEnumTypes;

interface

type

  TOperationType = (otInsert, otUpdate, otDelete);
  TFormMode = (fmRegister, fmSearch);
  TTypePerson = (tpProvider, tpCustomer);
  TSearchEntityType = (setCategory, setSubCategory, setCustomer, setProvider, setTypePayment, setFormPayment,
                       setCity);
  TTypeMovement = (tmRevenues, tmExpenses);
  TMessageType = (mtSuccess, mtWarning, mtError, mtInformation);

implementation

end.
