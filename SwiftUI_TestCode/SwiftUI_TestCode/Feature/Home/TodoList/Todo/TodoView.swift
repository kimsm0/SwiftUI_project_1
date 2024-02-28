//
//  TodoView.swift
//  SwiftUI_TestCode
//
//  Created by kimsoomin_mac2022 on 2/28/24.
//

import SwiftUI

struct TodoView: View {
    
    @EnvironmentObject private var pathModel: PathModel
    @EnvironmentObject private var todoListViewModel: TodoListViewModel
    @StateObject private var todoViewModel = TodoViewModel()
    
    
    var body: some View {
        VStack{
            CustomNavigationBar(leftBtnAction: {
                pathModel.paths.removeLast()
            }, rightBtnAction: {
                todoListViewModel.addTodo(
                    Todo(title: todoViewModel.title, time: todoViewModel.time, day: todoViewModel.day, selected: false)
                )
                pathModel.paths.removeLast()
            }, naviType: .create )
            
            //메인 타이틀
            TitleView()
                .padding(.top, 20)
            
            Spacer()
                .frame(height: 20)
            
            //제목 입력 가이드 텍스트필드
            TodoTextFieldView(todoViewModel: todoViewModel)
                .padding(.leading, 20)
            //시간 선택 피커
            TimePickerView(todoViewModel: todoViewModel)
            //날짜 선택 피커
            DatePickerView(todoViewModel: todoViewModel)
                .padding(.leading, 20)
            
            Spacer()
            
        }
    }
}

// MARK: - Todo 메인 타이틀

private struct TitleView: View {
    fileprivate var body: some View {
        HStack {
            Text("To do list를 \n추가해보세요.")
            
            Spacer()
        }.font(.system(size: 20, weight: .bold))
            .padding(.leading, 20)
    }
}


// MARK: - 제목 입력 가이드 텍스트필드
private struct TodoTextFieldView: View {
    @ObservedObject private var todoViewModel: TodoViewModel
    
    fileprivate init(todoViewModel: TodoViewModel) {
        self.todoViewModel = todoViewModel
    }
    
    fileprivate var body: some View {
        TextField("제목을 입력하세요.", text: $todoViewModel.title)
    }
}

// MARK: - 시간 선택 피커
private struct TimePickerView: View {
    @ObservedObject private var todoViewModel: TodoViewModel
    
    fileprivate init(todoViewModel: TodoViewModel) {
        self.todoViewModel = todoViewModel
    }
    
    fileprivate var body: some View {
        VStack{
            Rectangle()
                .fill(Color.gray0)
                .frame(height: 1)
            
            DatePicker("", 
                       selection: $todoViewModel.time,
                       displayedComponents: [.hourAndMinute])
            .labelsHidden()
            .datePickerStyle(WheelDatePickerStyle())
            .frame(maxWidth: .infinity, alignment: .center)
            
            Rectangle()
                .fill(Color.gray0)
                .frame(height: 1)            
        }
    }
}

// MARK: - 날짜 선택 피커
private struct DatePickerView: View {
    @ObservedObject private var todoViewModel: TodoViewModel
    
    fileprivate init(todoViewModel: TodoViewModel) {
        self.todoViewModel = todoViewModel
    }
    
    fileprivate var body: some View {
        VStack(spacing: 5) {
            HStack{
                Text("날짜")
                    .foregroundColor(.gray2)
                Spacer()
            }
            HStack{
                Button(action: {
                    todoViewModel.setIsDisplayCalendar(true)
                }, label: {
                    Text("\(todoViewModel.day.formattedDay)")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.customKeyColor)
                })
                .popover(isPresented: $todoViewModel.isDislayCalendar, content: {
                    DatePicker("", //제목없음
                               selection: $todoViewModel.day,
                               displayedComponents: [.date]
                    ).labelsHidden()
                        .datePickerStyle(.graphical)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                        .onChange(of: todoViewModel.day){ _ in
                            todoViewModel.setIsDisplayCalendar(false)
                        }
                })
                Spacer()
            }
        }
    }
}


#Preview {
    TodoView()
}
