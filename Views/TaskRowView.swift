import SwiftUI

struct TaskRowView: View {
    let task: Task
    @ObservedObject var viewModel: TaskViewModel
    
    var body: some View {
        HStack {
            Button(action: { viewModel.toggleTask(task) }) {
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(task.isCompleted ? .green : .gray)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(task.title)
                    .strikethrough(task.isCompleted)
                
                HStack {
                    if let category = viewModel.getCategoryById(task.categoryId) {
                        Text(category.name)
                            .font(.caption)
                            .foregroundColor(Color(category.color))
                            .padding(.horizontal, 8)
                            .padding(.vertical, 2)
                            .background(Color(category.color).opacity(0.2))
                            .cornerRadius(4)
                    }
                    
                    Text(task.dueDate.formatted(date: .abbreviated, time: .omitted))
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                if let notes = task.notes, !notes.isEmpty {
                    Text(notes)
                        .font(.caption2)
                        .foregroundColor(.gray)
                }
            }
            
            Spacer()
        }
        .padding(.vertical, 4)
    }
}
