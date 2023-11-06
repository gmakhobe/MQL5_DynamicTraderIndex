//+------------------------------------------------------------------+
//|                                          DynamicTradersIndex.mq5 |
//|                                                           GivenM |
//|              https://github.com/gmakhobe/MQL5_DynamicTraderIndex |
//+------------------------------------------------------------------+
#property copyright "GivenM"
#property link      "https://github.com/gmakhobe/MQL5_DynamicTraderIndex"
#property version   "1.00"
#property indicator_chart_window
//--- input parameters
input int      PriceLineLookBack=14;
input int      TradeSignalLineLookBack=7;
input int      MarketBaseLineLookBack=34;
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator buffers mapping
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
//---
   
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+
