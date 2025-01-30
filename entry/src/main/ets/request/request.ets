import axios, { AxiosError, AxiosResponse, InternalAxiosRequestConfig } from '@ohos/axios'
import { RequestURIConstantValue } from 'constantvalue'

export const request = axios.create({
  baseURL: RequestURIConstantValue.REQUEST_BASE_URL,
  timeout: 10000
})

// 请求拦截, 加入 header 参数
request.interceptors.request.use((config: InternalAxiosRequestConfig) => {
  config.headers.set('request-from', 'harmony-application')
  if (!config.headers.has('Content-Type')) {
    config.headers.set('Content-Type', 'application/json; charset=UTF-8')
  }
  return config;
}, (error: AxiosError) => {
  // 打印日志
  return Promise.reject(error)
})

// 响应拦截
request.interceptors.response.use((response: AxiosResponse) => {
  if (response.data.requestSuccess) { //响应成功
    return response.data
  } else { // 响应失败
    // 打印日志
  }
  return response.data;
}, (error: AxiosError) => {
  // 打印日志
  return Promise.reject(error)
})