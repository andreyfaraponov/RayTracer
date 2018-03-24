/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   sh_square.cl                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: pprivalo <pprivalo@student.unit.ua>        +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/01/23 20:42:03 by pprivalo          #+#    #+#             */
/*   Updated: 2018/01/23 20:42:16 by pprivalo         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "ft_rt.h"

short				cube_cross(t_object *p, t_ray *r, float *t)
{
    float   t_min;
    float   t_buf;
    short   flag;
    float   h;

    t_min = INFINITY;
    h = v_length(p->pos1 - p->pos2) / sqrt(2.0);
    if ((flag = square_cross(p, r, &t_buf)))
        t_min = t_buf < t_min ? t_buf : t_min;
    p->pos1 = p->pos1 + v_mult_d(p->dir, h);
    p->pos2 = p->pos2 + v_mult_d(p->dir, h);
    if ((flag = square_cross(p, r, &t_buf)))
        t_min = t_buf < t_min ? t_buf : t_min;
    *t = t_min;
    return(flag);
}

short				get_cube_data(t_ray *ray, t_object square, float t)
{
	ray->p_hit = ray->orig + v_mult_d(ray->dir, t);
	ray->n_hit = square.dir;
	return (1);
}