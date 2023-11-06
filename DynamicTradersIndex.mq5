//+------------------------------------------------------------------+
//|                                          DynamicTradersIndex.mq5 |
//|                                                           GivenM |
//|              https://github.com/gmakhobe/MQL5_DynamicTraderIndex |
//+------------------------------------------------------------------+
#property copyright "GivenM"
#property link      "https://github.com/gmakhobe/MQL5_DynamicTraderIndex"
#property version   "1.00"
//--- Settings
#property indicator_separate_window
#property indicator_buffers 6
#property indicator_plots   1
#property indicator_applied_price PRICE_TYPICAL

//--- input parameters
input int               RSILookBack = 13;
input int               PriceLineLookBack = 2;
input int               TradeSignalLineLookBack = 7;
input int               MarketBaseLineLookBack = 34;
const string            IndicatorSymbol = Symbol();
input ENUM_TIMEFRAMES   IndicatorTimeframe = PERIOD_CURRENT;
//--- Drawings
#property indicator_label1  "TDI Signal"
#property indicator_type1   DRAW_COLOR_LINE
#property indicator_color1  clrRed,clrGreen
#property indicator_style1  STYLE_SOLID
#property indicator_width1  1

//--- Imports
#include <MovingAverages.mqh>
//--- Buffers
double         PriceLine[];
double         TradeSignal[];
double         MakertBaseLine[];
double         RSIData[];
double         TDILine[];
double         TDILineColor[];
//-- Handlers
int            RSIHandler;
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator buffers mapping
   SetIndexBuffer(0, TDILine, INDICATOR_DATA);
   SetIndexBuffer(1, TDILineColor, INDICATOR_COLOR_INDEX);
   SetIndexBuffer(2, PriceLine, INDICATOR_DATA);
   SetIndexBuffer(3, TradeSignal, INDICATOR_DATA);
   SetIndexBuffer(4, MakertBaseLine, INDICATOR_DATA);
   SetIndexBuffer(5, RSIData, INDICATOR_CALCULATIONS);
   
   string shortname;
   StringConcatenate(shortname,"Traders Dynamic Index(", PriceLineLookBack, "," , RSILookBack,",", PriceLineLookBack,",", TradeSignalLineLookBack,",", MarketBaseLineLookBack,")");
   //--- set a label do display in DataWindow
   PlotIndexSetString(0,PLOT_LABEL,shortname);   
   //--- set a name to show in a separate sub-window or a pop-up help
   IndicatorSetString(INDICATOR_SHORTNAME,shortname);
   //--- set accuracy of displaying the indicator values
   IndicatorSetInteger(INDICATOR_DIGITS,2);
   
//---
   RSIHandler = iRSI(IndicatorSymbol, IndicatorTimeframe, RSILookBack, PRICE_CLOSE);

   if(RSIHandler == INVALID_HANDLE)
     {
      return INIT_FAILED;
     }
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,       // price[] array size
                const int prev_calculated,   // number of handled bars at the previous call
                const int begin,             // index number in the price[] array meaningful data starts from
                const double& price[])            // array of values for calculation)
  {
   if(!CopyBuffer(RSIHandler, 0, 0, rates_total, RSIData))
     {
      return rates_total;
     }

   int start;

   if(prev_calculated == 0)
     {
      start = 1;
     }
   else
     {
      start = prev_calculated - 1;
     }
   
   for (int i = start; i < rates_total; i++)
   {
      PriceLine[i] = SimpleMA(i, PriceLineLookBack, RSIData);
      TradeSignal[i] = SimpleMA(i, TradeSignalLineLookBack, PriceLine);
      MakertBaseLine[i] = SimpleMA(i, MarketBaseLineLookBack, PriceLine); 
      TDILine[i] = (PriceLine[i] + TradeSignal[i]) / 2;
      
      if (PriceLine[i] > TradeSignal[i])
      {
         TDILineColor[i] = 1;
      }
      
      if (PriceLine[i] < TradeSignal[i])
      {
         TDILineColor[i] = 0;
      }
      
      
      Print(PriceLine[i]);
   }

   return(rates_total);
  }
//+------------------------------------------------------------------+
