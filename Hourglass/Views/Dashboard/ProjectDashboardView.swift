import SwiftUI

struct ProjectDashboardView: View {
    var project: Project?
    
    var body: some View {
        Grid {
            GridRow {
//                ChartView(
//                    project: project,
//                    style: .column,
//                    source: .tasks
//                )
//                
//                ChartView(
//                    project: project,
//                    style: .line,
//                    source: .tasks
//                )                
            }
            
            GridRow {
//                ChartView(
//                    project: project,
//                    style: .burnup,
//                    source: .tasks
//                )
//                
//                ChartView(
//                    project: project,
//                    style: .donut,
//                    source: .tasks
//                )                
            }
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .topLeading
        )
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectDashboardView(project: .init(name: ""))
    }
}
