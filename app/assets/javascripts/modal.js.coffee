# Override Rails handling of confirmation

$.rails.allowAction = (element) ->
  # The message is something like "Are you sure?"
  message = element.data('confirm')
  # If there's no message, there's no data-confirm attribute, 
  # which means there's nothing to confirm
  return true unless message
  # Clone the clicked element (probably a delete link) so we can use it in the dialog box.
  $link = element.clone()
    # We don't necessarily want the same styling as the original link/button.
    .removeAttr('class')
    # We don't want to pop up another confirmation (recursion)
    .removeAttr('data-confirm')
    # We want a button
    .addClass('btn').addClass('btn-danger')
    # We want it to sound confirmy
    .html("Delete")
    
    # data-dismiss property is required for remote links
    .attr('data-dismiss', 'modal')

  # Create the modal box with the message
  modal_html = """
               <div id="myModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                  <div class="modal-content">                
                    <div class="modal-header">
                     <h5 class="modal-title">#{message}</h5>
                   <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                   <span aria-hidden="true">&times;</span>
                 </div>
                 <div class="modal-body">
                   <p>Are you sure you want to do this?</p>
                   <p>There's no turning back.</p>
                 </div>
                 <div class="modal-footer">
                   <button class="btn" data-dismiss="modal" aria-hidden="true">Cancel</button>
                 </div>
               </div>
              </div>
             </div>  
               """
  $modal_html = $(modal_html)

  # Add the new button to the modal box
  $modal_html.find('.modal-footer').append($link)
  
  # Pop it up
  $modal_html.modal()
  
  # Prevent the original link from working
  return false