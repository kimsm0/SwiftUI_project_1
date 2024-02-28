//
//  TodoView.swift
//  SwiftUI_TestCode
//
//  Created by kimsoomin_mac2022 on 2/28/24.
//
//하위뷰 생성 방법
//3번으로 사용하면 EnvironmentObject 등을 따로 또 생성해야 하는 단점이 있음.
//자주 사용되거나, 여러번 반복사용되는 경우는 따로 생성하는것이 유리

//1. property이용
//ex, var titleView: some View { Text("")  }
//2. func 이용해서 리턴
//ex, func titleView()-> some View
//3. 따로 생성

import SwiftUI

//todo, todoList뷰는 각각 독립적으로 구성했다.
struct TodoListView: View {
    @EnvironmentObject private var pathModel: PathModel
    @EnvironmentObject private var todoListViewModel: TodoListViewModel
    
    var body: some View {
        //zstack으로 플로팅 버튼을 구성한다.
        ZStack{
            //커스텀 네비게이션
            //타이틀
            //항목 리스트 또는 가이드 문구
            VStack {
                if !todoListViewModel.todos.isEmpty {
                    CustomNavigationBar(hasLeftBtn: false, hasRightBtn: true, rightBtnAction: {
                        todoListViewModel.naviRightButtonTabbed()
                    }, naviType: todoListViewModel.naviBarMode)
                }else{
                    Spacer()
                        .frame(height: 30) //비어있는 네비영역
                }
                
                TitleView()
                    .padding(.top, 20)
                                
                
                if todoListViewModel.todos.isEmpty {
                    AnnouncementView()
                }else {
                    TodoListContentView()
                        .padding(.top, 20)
                }
            }
            
            //플로팅버튼
            WriteFloatingButtonView()
                .padding(.trailing, 20)
                .padding(.bottom, 50)
        }
        .alert("To do List \(todoListViewModel.removeTodosCount)개를 삭제하시겠습니까?",
               isPresented: $todoListViewModel.showAlertRemoveTodo,
               actions: {
            Button("삭제", role: .destructive, action: {
                todoListViewModel.removeBtnTabbed()
            })
            Button("취소", role: .cancel, action: {})
        })
        
    }
}


// MARK: - SubView
private struct TitleView: View {
    @EnvironmentObject private var todoListViewModel: TodoListViewModel
    
    var body: some View {
        
        HStack {
            if todoListViewModel.todos.isEmpty {
                Text("To do list를\n추가해 보세요.")
            }else {
                Text("To do list \(todoListViewModel.todos.count)개가\n있습니다. ")
            }
            Spacer()
        }
        .font(.system(size: 30, weight: .bold))
        .padding(.leading, 30)
        
    }
}

// MARK: - TodoList 안내뷰

private struct AnnouncementView: View {
    
    fileprivate var body: some View {
        VStack(spacing: 15) {
            Spacer()
            
            Image("pencil")
                .renderingMode(.template)
            
            Text("\"매일 아침 5시 운동!\"")
            Text("\"내일 8시 수강 신청!\"")
            Text("\"1시 반 점심약속\"")
            
            Spacer()
            
        }.font(.system(size: 16))
            .foregroundColor(.gray2)
    }
}

struct TodoListContentView: View {
    @EnvironmentObject private var todoListViewModel: TodoListViewModel
    
    var body: some View {
        
        VStack{
            HStack{
                Text("할일 목록")
                    .font(.system(size: 16, weight: .bold))
                    .padding(.leading, 20)
                
                Spacer()
            }
            
            ScrollView(.vertical) {
                VStack {
                    Rectangle()
                        .fill(Color.customGray_0)
                        .frame(height: 1) //divider사용도 가능
                    
                    ForEach(todoListViewModel.todos, id: \.self){ todo in
                        //항목별 셀 만들기
                        //각 셀에 데이터 넣기.
                        TodoCellView(todo: todo)
                    }
                }
            }
        }
    }
}


// MARK: Todo Cell

private struct TodoCellView: View {
    @EnvironmentObject private var todoListViewModel: TodoListViewModel
    @State private var isRemoveSelected: Bool
    private var todo: Todo
    
    fileprivate init(isRemoveSelected: Bool = false, todo: Todo) {
        _isRemoveSelected = State(initialValue: isRemoveSelected) //State에 초기값 할당
        self.todo = todo
    }
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                if !todoListViewModel.isEditTodoMode { //체크박스 노출 필요
                    Button(action: { todoListViewModel.selectedBoxTabbed(todo) }, label: {
                        todo.selected ? Image("selectedBox") : Image("unselectedBox")
                    })
                }
                
                VStack (alignment: .leading,spacing: 5, content: {
                    Text(todo.title)
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                    
                    Text(todo.convertedDayAndTime)
                        .font(.system(size: 16))
                        .foregroundColor(.customGray_2)
                })
                
                Spacer()
                
                if todoListViewModel.isEditTodoMode {
                    //체크박스
                    Button(action: { 
                        isRemoveSelected.toggle()
                        todoListViewModel.todoRemoveSelectedBoxTabbed(todo)
                    }, label: {
                        isRemoveSelected ? Image("selectedBox") : Image("unselectedBox")
                    })
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 10)
        
        Rectangle()
            .fill(Color.gray0)
            .frame(height: 1)
    }
}

// MARK: Todo write 플로팅 버튼

private struct WriteFloatingButtonView: View {
    @EnvironmentObject private var pathModel: PathModel
    
    var body: some View {
     
        VStack{
            Spacer()
            
            HStack{
                Spacer()
                
                Button(action: {
                    pathModel.paths.append(.todoView) //작성화면으로 이동
                }, label: {
                    Image("floatingButton")
                })
            }
        }
    }
}

#Preview {
    TodoListView()
        .environmentObject(PathModel())
        .environmentObject(TodoListViewModel())
}
