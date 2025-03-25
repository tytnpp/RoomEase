<h1>Sign Up</h1>

<%= form_with(model: resource, url: registration_path(resource_name)) do |f| %>
  <div>
    <%= f.label :email %>
    <%= f.email_field :email %>
  </div>

  <div>
    <%= f.label :password %>
    <%= f.password_field :password %>
  </div>

  <div>
    <%= f.label :password_confirmation %>
    <%= f.password_field :password_confirmation %>
  </div>

  <%= f.submit "Sign Up" %>
<% end %>

<%= link_to 'Login', new_user_session_path %>
