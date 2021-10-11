object FrmPrinc: TFrmPrinc
  Left = 217
  Top = 131
  Width = 699
  Height = 461
  Caption = 'Directory change'
  Color = clBtnFace
  Constraints.MinHeight = 398
  Constraints.MinWidth = 500
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object gbParams: TGroupBox
    Left = 0
    Top = 0
    Width = 691
    Height = 113
    Align = alTop
    Caption = ' Parameters '
    TabOrder = 0
    DesignSize = (
      691
      113)
    object EdtDir: TLabeledEdit
      Left = 16
      Top = 40
      Width = 665
      Height = 24
      Anchors = [akLeft, akTop, akRight]
      EditLabel.Width = 81
      EditLabel.Height = 16
      EditLabel.Caption = 'Path to folder:'
      TabOrder = 0
      Text = 'c:\'
    end
    object BtnStart: TButton
      Left = 16
      Top = 72
      Width = 121
      Height = 25
      Caption = 'Start watch'
      TabOrder = 1
      OnClick = BtnStartClick
    end
    object BtnStop: TButton
      Left = 144
      Top = 72
      Width = 121
      Height = 25
      Caption = 'Stop watch'
      Enabled = False
      TabOrder = 2
      OnClick = BtnStopClick
    end
    object BtnParc: TButton
      Left = 921
      Top = 52
      Width = 35
      Height = 28
      Anchors = [akTop, akRight]
      Caption = '...'
      TabOrder = 3
      OnClick = BtnParcClick
    end
  end
  object gbInfos: TGroupBox
    Left = 0
    Top = 113
    Width = 691
    Height = 301
    Align = alClient
    Caption = '  Notifications  '
    TabOrder = 1
    object lbChanges: TListBox
      Left = 2
      Top = 18
      Width = 687
      Height = 281
      Align = alClient
      ItemHeight = 16
      TabOrder = 0
    end
  end
  object SB: TStatusBar
    Left = 0
    Top = 414
    Width = 691
    Height = 19
    Panels = <
      item
        Text = 'Watch stopped'
        Width = 550
      end
      item
        Text = '0 element'
        Width = 50
      end>
    OnResize = SBResize
  end
end
