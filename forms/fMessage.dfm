object frmMessage: TfrmMessage
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Mensagem'
  ClientHeight = 466
  ClientWidth = 743
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Calibri'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlTitle: TPanel
    Left = 0
    Top = 0
    Width = 743
    Height = 33
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 0
    ExplicitWidth = 890
  end
  object pnlGeneral: TPanel
    Left = 0
    Top = 33
    Width = 743
    Height = 369
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 29
    object lblMessageType: TLabel
      Left = 144
      Top = 70
      Width = 214
      Height = 40
      Caption = 'lblMessageType'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -33
      Font.Name = 'Calibri'
      Font.Style = []
      ParentFont = False
    end
    object lblMessage: TLabel
      AlignWithMargins = True
      Left = 10
      Top = 176
      Width = 723
      Height = 183
      Margins.Left = 10
      Margins.Top = 0
      Margins.Right = 10
      Margins.Bottom = 10
      Align = alBottom
      AutoSize = False
      Caption = 'lblMessage'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -20
      Font.Name = 'Calibri'
      Font.Style = []
      ParentFont = False
      WordWrap = True
      ExplicitLeft = 14
      ExplicitTop = 162
      ExplicitWidth = 843
    end
    object imgIcon: TImage
      Left = 23
      Top = 46
      Width = 96
      Height = 96
      Picture.Data = {
        0954506E67496D61676589504E470D0A1A0A0000000D49484452000000600000
        00600806000000E2987738000007974944415478DAED5D6B88555514DE37AA31
        88CAB2CC84D2C4821A5F51BF0CA5874A39BD0DA2F794913F9CD45048E9311AA5
        90E458FE98E8A1254590D5F482CC9E96BF926CB2828C72127A4F6561E95474FB
        16675D3C8CF7EEC7D9AF33BA3F58ECFB639FB5D6FEBE73CFD967EF7DF6A98884
        A8A8C44EE040471220329200919104888C24406424012223091019A516A05AAD
        1E83E24CD829B0D15C9E083B0CD6041BC655BF87F5C176C376C0B6C1BEE47273
        A552F925765B1AA1540280F04128CE879DCB36CE91EB6ED8DB6C6F42903DB1DB
        5A43290400F193515C07BB127684E7707FC09E83AD8510EFC56E7B340140FAA1
        285A610B60A322A5F115EC01D86A88F1778C04820BC09799592223FE84188DAE
        83EF44264467E8CB53500140FE74140FC14E0E19D7005FC36E8308AF850A1844
        00104F3D9795B04B4335CC125DB039106287EF40DE0500F997A058033BCA772C
        C7D809BB1122BCE43388370140FC2122BBAECEB174D50BDB08FB0CF6B9C8FAF6
        BFC2F6809C1F38D6F128E8DE72B4C89E154E839D0E9B041B62199FFEB90B10EB
        1F1F3C791100840C46F132ECEC822E3E823D0B5B8F867F6299CB5814D36057C1
        CE28E8E603D8C5C8E537D75C3917000D1E8E62BDC8CE4013EC823D0A7B020DFD
        D4755E9C5B338A9B60B7C00E373C9CFE81D390DBB72E73722A001A487FFF3760
        27191CF63BEC615847A821031EE2980B6B831D6970E837B0A9C8739BAB5C9C09
        C067FE266146FE5AD87C34E827577918E67C1C8AE5227B0AD7058930D1D53FC1
        89007CCDA71B65B3E6213D22EB61441F0AE0FC6928640D6C84E62174899CE4E2
        9E602D000F29BC25F46FB8D4C76E45F23B6D63BB04DA41DDE4D542FF59856ECC
        E7D90E61B810A043E87535ABB0454878996D4C9F407BEE4071BF26372BD19EB9
        36F1AC0440B274B6BCA0E1E75FD84C24FBA443AEBC01EDBA01C563B083555561
        97A35D5D456315168087173E860D565425F267F87EA2740D7E825F27D422D07D
        607CD1610B1B015E14EAEB259D21AD03E5CCAFD346FA27D07D41C55317DA7859
        91188504E051CD5735AA2E2CFB355FA3AD744F58AA51B5A5C828AAB1004888E6
        63A91BA61A522E7C56940D9AFF761ACA6E469B779BF82E2200DDF55728AAF5C0
        2694ADAB5914DC45DD22D4CF09F3D0E60E13DF460220115A8940D378C365D560
        E794E5214BB35D342E742D72EE94D4A187B577849C337A3A1E053F7DBAB14D05
        B81545A7A21A4D765FEF9D354760F25F874D842D43EE0B25759F12EA618B59F0
        F1886E7C6D01109CEAD25A1BD9043A0DAC9D8A047E0CC09D35FA915FC352E4BF
        A841FDA128BE10F2013CBA428C868FAA4E0E2602D0E486EAB2722F02DF1D803B
        6B3420BF86FBD08E3B1B1CB704C55D0AF79371FC469D3C4C04A027C39B255568
        3C7F449957A1E5DA2223BF86BA27130F65F708F97CC2E33876A64E2E5A0270D7
        9396FFC9FE7A2B10F476BFD4D94393FC1A16A34DED757C3C88629EE438BA140F
        D3E992EA0AD082E21545B531BE66B25CC1907C423BDAB4B88E1F1A76DFAA38F6
        221CAB7C58D51540A5F816042B3ADF1A04AEC8CFF9A379EB0992E3B5AE08BA02
        D0A09B6CA12CAD1A58EE9C3547704D3EFB9C2FB2551F8DD00D1FE35581940220
        102DEBA06EE541926AE36C572FF8820FF2D92FADB6E89654F90F3614BE7A657E
        74049822B289F646F8990369F57B43C217F9EC9BB8A313F35849359AC0DF20F3
        A323C06C91AD5A6884E71164864BE25CC027F9B918345F7085A44A1B7CAE92F9
        D01180C89F2DA9B20441EE71C29A2384209FE3D031B207CF55F0DB26F3A12300
        5D7EA648AA5C8320CF58B3E608A1C8E75857A3785A5265037C4F95F9D011806E
        AE632455CE4290CD56AC394248F2391EBDBFF6A1A4CA56F81F2BF3A123C07621
        1F071F89203D451BE10AA1C9E798C4CB7649951EC41829F3A12300F572642B8C
        87988EFFC0270D57AFC3717FD91090F3179C7C8E4BE342B26E662FE2C87A495A
        02D02B3B4D922A4D268B93E08F6ED8ED229BDC68B1152116F91C9B16A5C9265F
        FA106B90CC47500172E4D76025424CF2397E10019C5C82EA905FC3BBB0E9A622
        C4269F73087209B2BE094BC8AF81267A48843F351B1E9D7CCE8378F17E13B6EA
        866A905F83960865219F7309D20DB57A1033108040D378173612A14CE4733E41
        1EC4AC87220C45781F76417F11CA463EE7146428C2C9609CA108B4F69E44D8C5
        C7968E7CCE2BC8609CB3E1E82222F0EF32921F6C38DAE9848CA1089BB82C15F9
        DC8E3013321CCCE994A4A108BA08463EB721CC942407733E29EF5884A0E473FE
        4127E5BD2C4B7124420CF2832F4BF1B630CB5284E0E473CE61176671506F4B13
        0B8A108BFCF04B1339B0D7C5B9862244219FF38CB638D7FBF2744D1162921F6F
        793A27E0FD050D8508D1C8E7DCE2BDA0C109047945A98108B1C98FFF8A122712
        E425BD7E22C426BF1C2FE97132C15E536511444CF2398FF2BCA6CA09A517B5F7
        459817B57389A5AD0AF622EC56059C5CDAAC23439CCD3A38C9B45D4DACED6A72
        C9A60D9B2C90B62CDBDB8E81B96519279F36ED2B88B46DE5FEB06D65AE4169E3
        5643A4AD8BF551FEAD8B730D4D9B776B226D5FAFC6C0DBBE3E8FF4010739D227
        4CEA63FFF984491EE9233EFB227DC62AC381F119AB3CD287DC32A44F19464629
        04A8217DCCB364489FB34DF08E244064240122230910194980C8480244461220
        32920091F13F19D9369D1059023B0000000049454E44AE426082}
    end
  end
  object pnlMenu: TPanel
    Left = 0
    Top = 402
    Width = 743
    Height = 64
    Align = alBottom
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 2
    ExplicitWidth = 890
    object pnlButtonOk: TPanel
      Left = 265
      Top = 2
      Width = 196
      Height = 57
      Cursor = crHandPoint
      Align = alCustom
      BevelKind = bkFlat
      BevelOuter = bvNone
      Caption = 'Ok'
      Color = 7855338
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -33
      Font.Name = 'Calibri'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 0
      OnClick = pnlButtonOkClick
    end
  end
end