<h1>Login</h1>

<%= form_with(model: resource, url: session_path(resource_name)) do |f| %>
  <div>
    <%= f.label :email %>
    <%= f.email_field :email %>
  </div>

  <div>
    <%= f.label :password %>
    <%= f.password_field :password %>
  </div>

  <%= f.submit "Login" %>
<% end %>

<%= link_to 'Sign up', new_user_registration_path %>
