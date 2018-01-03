# 验证 JSON 及 validation

```java
// valid exception
@ExceptionHandler(MethodArgumentNotValidException.class)
@ResponseBody
public ResponseBean handleMethodArgumentNotValidException(
        MethodArgumentNotValidException ex) {
    BindingResult bindingResult = ex.getBindingResult();
    String errorMesssage = "Invalid Request:";

    for (FieldError fieldError : bindingResult.getFieldErrors()) {
        errorMesssage += fieldError.getDefaultMessage() + ", ";
    }

    System.out.println(bindingResult.getFieldError().getDefaultMessage());
    ResponseBean response = new ResponseBean();
    response.setErrcode("-11");
    response.setErrmsg(errorMesssage);
    return response;
}

// JSON convert exception
@ExceptionHandler(HttpMessageNotReadableException.class)
@ResponseBody
public ResponseBean handleHttpMessageNotReadableException(
        HttpMessageNotReadableException ex) {
    ResponseBean response = new ResponseBean();
    response.setErrcode("-22");
    response.setErrmsg("json convert failure!");
    return response;
}
```
