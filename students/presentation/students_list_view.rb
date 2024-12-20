require 'fox16'
require_relative '../data/sources/storage/json_strategy'
require_relative '../data/sources/storage/yaml_strategy'
require_relative '../data/sources/storage/student_list_storage'
require_relative '../data/sources/db/student_list_db_adapter'
require_relative '../data/sources/student_list'

include Fox

class StudentListView < FXMainWindow
  def initialize(app, students_list)
      super(app, "Student List", width: 1280, height: 720)
      self.filters = {}
      self.students_list = students_list
      self.current_page = 1
      self.items_per_page = 10

      main_frame = FXHorizontalFrame.new(self, LAYOUT_FILL_X | LAYOUT_FILL_Y)
      main_frame.backColor = FXRGB(255, 255, 255)

      filter_frame = FXVerticalFrame.new(main_frame, LAYOUT_FIX_WIDTH, width: 250, padding: 10)
      setup_filter_area(filter_frame)
      
      table_frame = FXVerticalFrame.new(main_frame, LAYOUT_FILL_X | LAYOUT_FILL_Y, padding: 10)
      setup_table_area(table_frame)
      
      control_frame = FXVerticalFrame.new(main_frame, LAYOUT_FIX_WIDTH, width: 150, padding: 10)
      setup_control_area(control_frame)
      
      load_data
      update_table
  end

  def setup_filter_area(parent)
    parent.backColor = FXRGB(255, 255, 255)
      filters_label = FXLabel.new(parent, "Фильтры")
      filters_label.backColor = FXRGB(240, 240, 255)

      initials_label = FXLabel.new(parent, "Фамилия и инициалы:")
      initials_label.backColor = FXRGB(255, 255, 255)
      
      name_text_field = nil
      name_text_field = FXTextField.new(parent, 25, opts: TEXTFIELD_NORMAL)
      
      self.filters['name'] = { text_field: name_text_field }
      add_filtering_row(parent, "Git:")
      add_filtering_row(parent, "Email:")
      add_filtering_row(parent, "Телефон:")
      add_filtering_row(parent, "Telegram:")
      FXButton.new(parent, "Сбросить фильтры", opts: BUTTON_TOOLBAR | LAYOUT_CENTER_X).tap do |button|
        button.backColor = FXRGB(255, 0, 0)
        button.textColor = FXRGB(255, 255, 255)
        button.connect(SEL_COMMAND) do
          button.backColor = FXRGB(180, 0, 0)
          
          app = button.app
          app.addTimeout(100) do
            button.backColor = FXRGB(255, 0, 0)
          end
          reset_filters
        end
      end
  end

  def add_filtering_row(parent, label)
    combo_label = FXLabel.new(parent, label)
    combo_label.backColor = FXRGB(255, 255, 255)
    combo = FXComboBox.new(parent, 3, opts: LAYOUT_FILL_X | FRAME_SUNKEN | FRAME_THICK | COMBOBOX_STATIC)
    combo.numVisible = 3
    combo.appendItem("Не важно")
    combo.appendItem("Да")
    combo.appendItem("Нет")
    text_field = FXTextField.new(parent, 15, opts: TEXTFIELD_NORMAL)
    text_field.visible = false
    self.filters[label] = { combo: combo, text_field: text_field }
    combo.connect(SEL_COMMAND) do
        text_field.visible = (combo.currentItem == 1)
        parent.recalc
    end
  end
    
  def setup_table_area(parent)
    parent.backColor = FXRGB(255, 255, 255)
    # Setup table
    self.table = FXTable.new(parent, opts: LAYOUT_FILL_X | LAYOUT_FILL_Y | TABLE_READONLY | TABLE_COL_SIZABLE)
    self.table.setTableSize(self.items_per_page, 3)
    self.table.defColumnWidth = 180
    self.table.rowHeaderWidth = 30
    self.table.columnHeader.connect(SEL_COMMAND) do |_, _, col|
        sort_table_by_column(col)
        update_table
    end

    # Setup navigation
    navigation_frame = FXHorizontalFrame.new(parent, opts: LAYOUT_FILL_X)
    navigation_frame.backColor = FXRGB(240, 240, 255)
    self.prev_button = FXButton.new(navigation_frame, "<", opts: BUTTON_TOOLBAR | LAYOUT_LEFT, padLeft: 10, padRight: 10)
    self.next_button = FXButton.new(navigation_frame, ">", opts: BUTTON_TOOLBAR | LAYOUT_RIGHT, padLeft: 10, padRight: 10)
    self.page_label = FXLabel.new(navigation_frame, "Страница 1", opts: LAYOUT_CENTER_X)
    page_label.backColor = FXRGB(240, 240, 255)
    self.prev_button.tap do |button|
      button.backColor = FXRGB(100, 100, 255)
      button.textColor = FXRGB(255, 255, 255)
      button.connect(SEL_COMMAND) do
        button.backColor = FXRGB(0, 0, 200)
        
        app = button.app
        app.addTimeout(100) do
          button.backColor = FXRGB(100, 100, 255)
        end
        change_page(1)
      end
    end
    self.next_button.tap do |button|
      button.backColor = FXRGB(100, 100, 255)
      button.textColor = FXRGB(255, 255, 255)
      button.connect(SEL_COMMAND) do
        button.backColor = FXRGB(0, 0, 200)
        
        app = button.app
        app.addTimeout(100) do
          button.backColor = FXRGB(100, 100, 255)
        end
        change_page(1)
      end
    end
  end

  def setup_control_area(parent)
    parent.backColor = FXRGB(255, 255, 255)
    add_button = FXButton.new(parent, "Добавить", opts: BUTTON_TOOLBAR | LAYOUT_FILL_X)
    add_button.tap do |button|
      button.backColor = FXRGB(100, 100, 255)
      button.textColor = FXRGB(255, 255, 255)
      button.connect(SEL_COMMAND) do
        button.backColor = FXRGB(0, 0, 200)
        
        app = button.app
        app.addTimeout(100) do
          button.backColor = FXRGB(100, 100, 255)
        end
        #TODO add logic
      end
    end
    delete_button = FXButton.new(parent, "Удалить", opts: BUTTON_TOOLBAR | LAYOUT_FILL_X)
    delete_button.tap do |button|
      button.backColor = FXRGB(100, 100, 255)
      button.textColor = FXRGB(255, 255, 255)
      button.connect(SEL_COMMAND) do
        button.backColor = FXRGB(0, 0, 200)
        
        app = button.app
        app.addTimeout(100) do
          button.backColor = FXRGB(100, 100, 255)
        end
        #TODO add logic
      end
    end
    change_button = FXButton.new(parent, "Изменить", opts: BUTTON_TOOLBAR | LAYOUT_FILL_X)
    change_button.tap do |button|
      button.backColor = FXRGB(100, 100, 255)
      button.textColor = FXRGB(255, 255, 255)
      button.connect(SEL_COMMAND) do
        button.backColor = FXRGB(0, 0, 200)
        
        app = button.app
        app.addTimeout(100) do
          button.backColor = FXRGB(100, 100, 255)
        end
        #TODO add logic
      end
    end
    update_button = FXButton.new(parent, "Обновить", opts: BUTTON_TOOLBAR | LAYOUT_FILL_X)
    update_button.tap do |button|
      button.backColor = FXRGB(100, 100, 255)
      button.textColor = FXRGB(255, 255, 255)
      button.connect(SEL_COMMAND) do
        button.backColor = FXRGB(0, 0, 200)
        
        app = button.app
        app.addTimeout(100) do
          button.backColor = FXRGB(100, 100, 255)
        end
        #TODO add logic
      end
    end
  end

  def update_table
    return if self.data.nil? || self.data.count_of_rows <= 1
    total_pages = (self.data.count_of_rows.to_f / self.items_per_page).ceil
    self.page_label.text = "Страница #{self.current_page} из #{total_pages}"
  
    # Calculate start and end indexes. 
    # End index is minimal index in start + count of display rows and tota count of rows
    start_index = (self.current_page - 1) * self.items_per_page
    end_index = [start_index + self.items_per_page - 1, self.data.count_of_rows - 1].min
  
    # Create array of display rows
    rows_to_display = (start_index..end_index).map do |row_idx|
      (0...self.data.count_of_columns).map do |col_idx|
          self.data.get_by_index(row_idx, col_idx)
      end
    end
  
    # Update table
    row_count = rows_to_display.length
    column_count = self.data.count_of_columns
  
    self.table.setTableSize(row_count, column_count)
    self.table.setColumnWidth(0, 30)
  
    (0...row_count).each do |row_idx|
      (0...column_count).each do |col_idx|
          value = rows_to_display[row_idx][col_idx]
          self.table.setItemText(row_idx, col_idx, value.to_s)
      end
    end
  end

  def change_page(offset)
      new_page = self.current_page + offset
      total_pages = (self.students_list.get_student_short_count.to_f / self.items_per_page).ceil
      return if new_page < 1 || new_page > total_pages
      self.current_page = new_page
      update_table
  end

  def load_data
      self.data = self.students_list.get_k_n_student_short_list(1, self.students_list.get_student_short_count).get_data
      puts "data: #{self.data.count_of_columns}"
  end

  def sort_table_by_column(col_idx=0)
      return if self.data.nil? || self.data.count_of_rows <= 1
      headers = (0...self.data.count_of_columns).map {|col_idx| self.data.get_by_index(0, col_idx)}
      rows = (1...self.data.count_of_rows).map do |row_idx|
          (0...self.data.count_of_columns).map {|column_idx| self.data.get_by_index(row_idx, column_idx)}
      end
      self.sort_order ||= {}
      self.sort_order[col_idx] = !sort_order.fetch(col_idx, false)
      sorted_rows = rows.sort_by do |row| 
          value = row[col_idx]
          value.nil? ? "\xFF" * 1000 : value
      end
      sorted_rows.reverse! unless self.sort_order[col_idx]
      all_data = [headers] + sorted_rows
      self.data = Data_table.new(all_data)
  end

  def create
      super
      show(PLACEMENT_SCREEN)
  end

  private
  attr_accessor :filters, :students_list, :current_page, :items_per_page, :table, :prev_button, :next_button, :page_label, :sort_order, :data
  def reset_filters
      self.filters.each do |key, field|
          field[:combo].setCurrentItem(0) if !field[:combo].nil?
          field[:text_field].text = ""
          field[:text_field].visible = false if key != 'name'
      end
      update_table
  end
end