//
//  TodoListViewModel.swift
//  SwiftUI_TestCode
//
//  Created by kimsoomin_mac2022 on 2/28/24.
//

import Foundation

class TodoListViewModel: ObservableObject {
    @Published var todos: [Todo]
    @Published var isEditTodoMode: Bool //작성중 모드
    @Published var removeTodos: [Todo]
    @Published var showAlertRemoveTodo: Bool //삭제 알럿 호출 바인딩 데이터
    
    var removeTodosCount: Int {
        removeTodos.count
    }
    
    var naviBarMode: NavigationBtnType { //투두리스트 화면에서 편집 모드로 바뀌면 네비게이션 변경 필요함.
        isEditTodoMode ? .complete : .edit
    }
    
    init(todos: [Todo] = [], isEditTodoMode: Bool = false , removeTodos: [Todo] = [], showAlertRemoveTodo: Bool = false) {
        self.todos = todos
        self.isEditTodoMode = isEditTodoMode
        self.removeTodos = removeTodos
        self.showAlertRemoveTodo = showAlertRemoveTodo
    }
}

//비지니스 로직
extension TodoListViewModel {
    
    func selectedBoxTabbed(_ todo: Todo) {
        if let index = todos.firstIndex(where: { $0 == todo }){ //지금 있는 리스트에 들어온 데이터가 있으면, 체크하도록
            todos[index].selected.toggle()
        }
    }
    
    func addTodo(_ todo: Todo){ //전달된 투두를 리스트에 추가함.
        todos.append(todo)
    }
    
    func naviRightButtonTabbed() { //navi 우측 버튼 액션 (편집)
        if isEditTodoMode {
            if removeTodos.isEmpty {
                isEditTodoMode = false
            }else {
                //편집 닫을건지 확인 알럿
                showAlertRemoveTodo = true 
            }
        }else{
            isEditTodoMode = true
        }
    }
    
    func showAlertRemoveTodo(_ isDisplay: Bool){
        showAlertRemoveTodo = isDisplay
    }
    
    func todoRemoveSelectedBoxTabbed(_ todo: Todo){ //우측 체크 박스 선택시 액션
     
        if let index = removeTodos.firstIndex(where: { $0 == todo }){
            removeTodos.remove(at: index)
        }else {
            removeTodos.append(todo)
        }
    }
    
    func removeBtnTabbed(isConfirm: Bool){
        if isConfirm {
            todos.removeAll(where: {
                removeTodos.contains($0) //전체 리스트에서 삭제하기로 체크한 항목만 삭제
            })
            removeTodos = []
        }        
        isEditTodoMode = false        
    }
}
