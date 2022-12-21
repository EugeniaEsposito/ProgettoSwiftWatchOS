//
//  ComplicationController.swift
//  Sord2 WatchKit Extension
//
//  Created by Eugenia Esposito on 23/01/2020.
//  Copyright © 2020 iOS Foundation. All rights reserved.
//

import ClockKit


class ComplicationController: NSObject, CLKComplicationDataSource, DataSourceChangedDelegate {
    func dataSourceDidUpdate(dataSource: DataSource) {
        switch dataSource.item {
        case .Dollari(let dollariItem):
            defaults.set(dollariItem, forKey: "dollariComplication")
        case .Currency(let currencyItem):
            defaults.set(currencyItem, forKey: "currencyComplication")
        case .Period(_):
            return
        case .Unknown:
            return
        }
    }
    
    
    // MARK: - Timeline Configuration
    
    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        handler([.forward, .backward])
    }
    
    func getTimelineStartDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(Date())
    }
    
    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(Date(timeIntervalSinceNow: 30))
    }
    
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.showOnLockScreen)
    }
    
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        // Call the handler with the current timeline entry
        WatchSessionManager.sharedManager.addDataSourceChangedDelegate(delegate: self)
        let limit = defaults.string(forKey: "dollariComplication")
        let currency = defaults.string(forKey: "currencyComplication")
        let lastDollar = defaults.integer(forKey: "Limite")
        switch complication.family {
        case .circularSmall:
            let template = CLKComplicationTemplateCircularSmallRingText()
            template.textProvider = CLKSimpleTextProvider(text: String(Int(spesa)))
            template.ringStyle = CLKComplicationRingStyle.closed
            if limit != nil && (String(lastDollar) == limit) {
                template.fillFraction = spesa/Float(limit ?? "0")!
            } else {
                if firstDollar == 0 {
                    template.fillFraction = spesa/Float(dollari)
                }
                else {
                    template.fillFraction = spesa/Float(firstDollar)
                }
            }
            let entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
            handler(entry)
        case .modularSmall:
            let template = CLKComplicationTemplateModularSmallRingText()
            template.textProvider = CLKSimpleTextProvider(text: String(Int(spesa)))
            template.ringStyle = CLKComplicationRingStyle.closed
            if limit != nil && (String(lastDollar) == limit) {
                template.fillFraction = spesa/Float(limit ?? "0")!
            } else {
                if firstDollar == 0 {
                    template.fillFraction = spesa/Float(dollari)
                }
                else {
                    template.fillFraction = spesa/Float(firstDollar)
                }
            }
            let entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
            handler(entry)
        case .modularLarge:
            let template = CLKComplicationTemplateModularLargeColumns()
            template.row1Column1TextProvider = CLKSimpleTextProvider(text: "Limit")
            if limit != nil && (String(lastDollar) == limit){
                template.row1Column2TextProvider = CLKSimpleTextProvider(text: limit!)
            } else {
                if firstDollar == 0 {
                    template.row1Column2TextProvider = CLKSimpleTextProvider(text: String(dollari))
                }
                else {
                    template.row1Column2TextProvider = CLKSimpleTextProvider(text: String(firstDollar))
                }
            }
            template.row2Column1TextProvider = CLKSimpleTextProvider(text: "Expense")
            template.row2Column1TextProvider.tintColor = .red
            template.row2Column2TextProvider = CLKSimpleTextProvider(text: String(Int(spesa)))
            template.row3Column1TextProvider = CLKSimpleTextProvider(text: "Budget")
            template.row3Column1TextProvider.tintColor = .green
            if limit != nil && (String(lastDollar) == limit) {
                template.row3Column2TextProvider = CLKSimpleTextProvider(text: String((Int(limit!) ?? 0)-Int(spesa)))
            } else {
                if firstDollar == 0 {
                    template.row3Column2TextProvider = CLKSimpleTextProvider(text: String(dollari-Int(spesa)))
                }
                else {
                    template.row3Column2TextProvider = CLKSimpleTextProvider(text: String(firstDollar-Int(spesa)))
                }
            }
            let entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
            handler(entry)
        case .utilitarianSmall:
            let template = CLKComplicationTemplateUtilitarianSmallRingText()
            template.textProvider = CLKSimpleTextProvider(text: String(Int(spesa)))
            template.ringStyle = CLKComplicationRingStyle.closed
            if limit != nil && (String(lastDollar) == limit) {
                template.fillFraction = spesa/Float(limit ?? "0")!
            } else {
                if firstDollar == 0 {
                    template.fillFraction = spesa/Float(dollari)
                }
                else {
                    template.fillFraction = spesa/Float(firstDollar)
                }
            }
            let entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
            handler(entry)
        case .graphicCircular:
            let template = CLKComplicationTemplateGraphicCircularClosedGaugeText()
            template.centerTextProvider = CLKSimpleTextProvider(text: String(Int(spesa)))
            if limit != nil && (String(lastDollar) == limit) {
                if Int(spesa) <= Int(limit ?? "0")! {
                    template.gaugeProvider = CLKSimpleGaugeProvider(style: .fill, gaugeColor: .green, fillFraction: spesa/Float(limit ?? "0")!)
                } else {
                    template.gaugeProvider = CLKSimpleGaugeProvider(style: .fill, gaugeColor: .red, fillFraction: 1)
                }
            } else {
                if firstDollar == 0 {
                    if Int(spesa) <= dollari {
                        template.gaugeProvider = CLKSimpleGaugeProvider(style: .fill, gaugeColor: .green, fillFraction: spesa/Float(dollari))
                    }
                    else {
                        template.gaugeProvider = CLKSimpleGaugeProvider(style: .fill, gaugeColor: .red, fillFraction: 1)
                    }
                }
                else {
                    if Int(spesa) <= firstDollar {
                        template.gaugeProvider = CLKSimpleGaugeProvider(style: .fill, gaugeColor: .green, fillFraction: spesa/Float(firstDollar))
                    }
                    else {
                        template.gaugeProvider = CLKSimpleGaugeProvider(style: .fill, gaugeColor: .red, fillFraction: 1)
                    }
                }
            }
            let entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
            handler(entry)
        case .graphicRectangular:
            let template = CLKComplicationTemplateGraphicRectangularTextGauge()
            template.headerTextProvider = CLKSimpleTextProvider(text: "Budget")
            if limit != nil && (String(lastDollar) == limit) {
                if currency != nil {
                    template.body1TextProvider = CLKSimpleTextProvider(text: "\((Int(limit ?? "0")!) - Int(spesa)) \(currency!)")
                } else {
                    template.body1TextProvider = CLKSimpleTextProvider(text: "\((Int(limit ?? "0") ?? 0) - Int(spesa)) Dollars")
                }
                if Int(spesa) <= Int(limit ?? "0")! {
                    template.gaugeProvider = CLKSimpleGaugeProvider(style: .fill, gaugeColor: .green, fillFraction: (1-(spesa/Float(limit ?? "0")!)))
                }
                else {
                    template.gaugeProvider = CLKSimpleGaugeProvider(style: .fill, gaugeColor: .red, fillFraction: 0)
                }
            } else {
                if firstDollar == 0 {
                    if currency != nil {
                        template.body1TextProvider = CLKSimpleTextProvider(text: "\(dollari - Int(spesa)) \(currency!)")
                    } else {
                        template.body1TextProvider = CLKSimpleTextProvider(text: "\(dollari - Int(spesa)) Dollars")
                    }
                    if Int(spesa) <= dollari {
                        template.gaugeProvider = CLKSimpleGaugeProvider(style: .fill, gaugeColor: .green, fillFraction: (1-(spesa/Float(dollari))))
                    }
                    else {
                        template.gaugeProvider = CLKSimpleGaugeProvider(style: .fill, gaugeColor: .red, fillFraction: 0)
                    }
                }
                else {
                    if currency != nil {
                        template.body1TextProvider = CLKSimpleTextProvider(text: "\(firstDollar - Int(spesa)) \(currency!)")
                    } else {
                        template.body1TextProvider = CLKSimpleTextProvider(text: "\(firstDollar - Int(spesa)) Dollars")
                    }
                    if Int(spesa) <= firstDollar {
                        template.gaugeProvider = CLKSimpleGaugeProvider(style: .fill, gaugeColor: .green, fillFraction: (1-(spesa/Float(firstDollar))))
                    }
                    else {
                        template.gaugeProvider = CLKSimpleGaugeProvider(style: .fill, gaugeColor: .red, fillFraction: 0)
                    }
                }
            }
            let entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
            handler(entry)
        default:
            handler(nil)
        }
        
    }
    
    func getTimelineEntries(for complication: CLKComplication, before date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries prior to the given date
        handler(nil)
    }
    
    func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries after to the given date
        handler(nil)
    }
    
    // MARK: - Placeholder Templates
    
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        // This method will be called once per supported complication, and the results will be cached
        if complication.family == .circularSmall {
            let template = CLKComplicationTemplateCircularSmallRingText()
            template.textProvider = CLKSimpleTextProvider(text: "100")
            template.ringStyle = CLKComplicationRingStyle.closed
            template.fillFraction = 1.0
            handler(template)
        }
        else if complication.family == .modularSmall {
            let template = CLKComplicationTemplateModularSmallRingText()
            template.textProvider = CLKSimpleTextProvider(text: "100")
            template.ringStyle = CLKComplicationRingStyle.closed
            template.fillFraction = 1.0
            handler(template)
        }
        else if complication.family == .modularLarge {
            let template = CLKComplicationTemplateModularLargeColumns()
            template.row1Column1TextProvider = CLKSimpleTextProvider(text: "Limit")
            template.row1Column2TextProvider = CLKSimpleTextProvider(text: "100")
            template.row2Column1TextProvider = CLKSimpleTextProvider(text: "Expense")
            template.row2Column1TextProvider.tintColor = .red
            template.row2Column2TextProvider = CLKSimpleTextProvider(text: "25")
            template.row3Column1TextProvider = CLKSimpleTextProvider(text: "Budget")
            template.row3Column1TextProvider.tintColor = .green
            template.row3Column2TextProvider = CLKSimpleTextProvider(text: "75")
            handler(template)
        }
        else if complication.family == .utilitarianSmall {
            let template = CLKComplicationTemplateUtilitarianSmallRingText()
            template.textProvider = CLKSimpleTextProvider(text: "100")
            template.ringStyle = CLKComplicationRingStyle.closed
            template.fillFraction = 1.0
            handler(template)
        }
        else if complication.family == .graphicCircular {
                let template = CLKComplicationTemplateGraphicCircularClosedGaugeText()
                template.centerTextProvider = CLKSimpleTextProvider(text: "100")
                template.gaugeProvider = CLKSimpleGaugeProvider(style: .fill, gaugeColor: .green, fillFraction: 1.0)
                handler(template)
            }
        else if complication.family == .graphicRectangular {
                let template = CLKComplicationTemplateGraphicRectangularTextGauge()
                template.headerTextProvider = CLKSimpleTextProvider(text: "Budget")
                template.body1TextProvider = CLKSimpleTextProvider(text: "50 Dollars")
                template.gaugeProvider = CLKSimpleGaugeProvider(style: .fill, gaugeColor: .green, fillFraction: 0.5)
            handler(template)
            }
        else {
            handler(nil)
        }
    }
    
}
