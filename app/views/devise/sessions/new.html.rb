<h1 class="text-3xl font-bold text-center text-gray-800 mb-6">Login</h1>

<div class="max-w-md mx-auto bg-white p-6 rounded-lg shadow-lg">
  <%= form_with(model: resource, url: session_path(resource_name), class: "space-y-4") do |f| %>
    <div>
      <%= f.label :email, class: "block text-gray-700 font-medium" %>
      <%= f.email_field :email, class: "w-full px-4 py-2 mt-1 border rounded-lg focus:ring-2 focus:ring-blue-500 focus:outline-none" %>
    </div>

    <div>
      <%= f.label :password, class: "block text-gray-700 font-medium" %>
      <%= f.password_field :password, class: "w-full px-4 py-2 mt-1 border rounded-lg focus:ring-2 focus:ring-blue-500 focus:outline-none" %>
      <% if flash[:alert] %>
        <p class="text-red-500 text-sm mt-1"><%= flash[:alert] %></p>
      <% end %>
    </div>

    <div>
      <%= f.submit "Login", class: "w-full bg-blue-600 text-white font-medium py-2 rounded-lg hover:bg-blue-700 transition" %>
    </div>
  <% end %>
</div>

<div class="text-center mt-4">
  <%= link_to 'Sign up', new_user_registration_path, class: "text-blue-600 hover:underline" %>
</div>
