class PopulateIssueStatusHistory < ActiveRecord::Migration
  def change
    
    # Algoritmo para calcular el historial pasado
    
    Issue.find_each do |i|
      last_change = nil
      #seria mejor seleccionar todos los cambios de status_id, ahorramos un bucle.
      #a continuación, iterar por id, que marcará el orden del cambio
      #comprobar si es la primera insercion, ejecutar dos inserts:
      # el primero marca el estatus inicial de la issue, y el from es desde la fecha de creacion y el to la fecha del journal
      # el segundo insert el from es la fecha del journal y el to a nulo
      # marcar como last_change el último detail
      #si no es la primera insercion:
      # actualizar el last_change com el to a la fecha from del journal
      # crear un nuevo historico, con from fecha de journal y to nulo
      #en caso de que no existe ningun journal, crear un historial con el estado del issue y from la fecha created_on del issue
      
      changes = i.journals.collect {|j| j.details.select {|d| d.prop_key == 'status_id' }}.flatten.sort
      if changes
        puts "Issue ##{i.id} - #{changes.count} changes "
        changes.each do |c|
          if last_change.nil?
            status_history = {
              :from => i.created_on,
              :status_id => c.old_value,
              :user_id => i.author_id,
              :issue_id => i.id,
              :to => c.journal.created_on
            }
            last_change = IssueStatusHistory.create!(status_history)            
          else
            last_change.to = c.journal.created_on
            last_change.save
          end
          
          status_history = {
            :from => c.journal.created_on,
            :status_id => c.value,
            :user_id => c.journal.user_id,
            :journal_id => c.journal_id,
            :previous_status_id => c.old_value,
            :issue_id => c.journal.journalized_id
          }
          last_change = IssueStatusHistory.create!(status_history)            
        end
      else
        status_history = {
          :from => i.created_on,
          :status_id => i.status_id,
          :user_id => i.author_id,
          :issue_id => i.id
        }
        IssueStatusHistory.create!(status_history)
      end
    end    
  end
end