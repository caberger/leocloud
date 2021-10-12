package at.htl.quarkus.demo.rest;
/** This package contains the REST Endpoints.
    When you do not use a rewrite proxy, you maybe want to use a CorsFilter like below or userquarkus.http.cors=true = true
 * Add access control headers to every request, so that no CORS error appears om client
 *  Only required if you do not use a reverse proxy.
 * 
 * We do not need this CorsFilter, because we use rewrite rules with the same hostname to access the api.
 * 
 *
 * <pre>{@code 
@Provider
public class CorsFilter implements ContainerResponseFilter {
    @Override
    public void filter(final ContainerRequestContext requestContext, final ContainerResponseContext responseContext) throws IOException {
        responseContext.getHeaders().add("Access-Control-Allow-Origin", "*");
        responseContext.getHeaders().add("Access-Control-Allow-Headers", "origin, content-type, accept, authorization");
        responseContext.getHeaders().add("Access-Control-Allow-Credentials", "true");
        responseContext.getHeaders().add("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS, HEAD");
        responseContext.getHeaders().add("Access-Control-Max-Age", "1209600");
    }
}}</pre>
*/
