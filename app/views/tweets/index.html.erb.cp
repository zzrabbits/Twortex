<html>
<head>
<STYLE>
a:link    {color:black;
          text-decoration:  none;}
a:visited {color:black;}
a:hover   {color:black;}
a:active  {color:black;}
</STYLE>
</head>

<h1>Keywords</h1>
<h1><%@keyword%></h1>
<%@num_row_keywords = (@keywords.size / 8.to_f).ceil%>
<table cellspacing='10'>
  <%for i in 0..@num_row_keywords%>
    <tr>
      <%for j in 0..9%>
        <% break if 10*i+j>=@keywords.size-1%>
          <td id="<%=@keywords[10*i+j]%>"><%= link_to "#{@keywords[10*i+j]}",:controller => :tweets, :action => :index,:keyword=>@keywords[10*i+j]%></td>
          <td>      </td>
      <%end%>
    </tr>
  <%end%>
</table>

<h2>Sub Keywords</h2>

<%@num_row_subkeywords = (@array.size / 8.to_f).ceil%>
<table cellspacing="10">
  <%for i in 0..@num_row_subkeywords%>
    <tr>
      <%for j in 0..9%>
        <% break if 10*i+j>=@array.size-1%>
        <% @size=@array[10*i+j][1]*1.5 %>
        <td><font size="<%=@size%>"><%= link_to "#{@array[10*i+j][0]}",:controller => :tweets, :action => :index,:subkeyword=>@array[10*i+j][0]%></td>
      <%end%>
    </tr>
  <%end%>
</table>

<script>
var elem = document.getElementById("<%=@selected_keyword%>")
elem.style.fontSize = "large"
elem.style.backgroundColor="#f3f3f3";
</script>


</html>
