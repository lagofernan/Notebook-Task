import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = TaskViewModel()
    @State private var showingAddTask = false
    @State private var selectedCategory: Category?
    
    var filteredTasks: [Task] {
        guard let selectedCategory = selectedCategory else {
            return viewModel.tasks
        }
        return viewModel.tasks.filter { $0.categoryId == selectedCategory.id }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Category Filter
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        CategoryFilterButton(title: "All", isSelected: selectedCategory == nil) {
                            selectedCategory = nil
                        }
                        
                        ForEach(viewModel.categories) { category in
                            CategoryFilterButton(
                                title: category.name,
                                color: Color(category.color),
                                isSelected: selectedCategory?.id == category.id
                            ) {
                                selectedCategory = category
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical, 8)
                .background(Color(.systemBackground))
                
                // Task List
                List {
                    ForEach(filteredTasks) { task in
                        TaskRowView(task: task, viewModel: viewModel)
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { index in
                            viewModel.deleteTask(filteredTasks[index])
                        }
                    }
                }
            }
            .navigationTitle("TaskSync")
            .navigationBarItems(
                leading: NavigationLink(destination: CategoriesView(viewModel: viewModel)) {
                    Text("Categories")
                },
                trailing: Button(action: { showingAddTask = true }) {
                    Image(systemName: "plus")
                }
            )
            .sheet(isPresented: $showingAddTask) {
                AddTaskView(viewModel: viewModel)
            }
        }
    }
}
￼Enter
