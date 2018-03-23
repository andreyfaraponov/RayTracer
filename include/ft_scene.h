/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_scene.h                                         :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: vkozlov <vkozlov@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/01/22 22:15:03 by vkozlov           #+#    #+#             */
/*   Updated: 2018/03/23 11:16:29 by vkozlov          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef FT_SCENE_H
# define FT_SCENE_H
# define O_SPHERE		1
# define O_CON			2
# define O_PLANE		3
# define O_CYL			4
# define O_DISK			5
# define O_TRIANGLE		6
# define O_PARABOLOID	7
# define O_SQUARE		8
# define L_PAR			1
# define L_LAMP			2
# define L_AMBIENT		3
# define L_AREA			4
# define T_CHECK		2
# define T_GRAD1		3
# define T_GRAD2		4
# define T_CIRC			5
# define T_BRICK		6




typedef float	t_vector __attribute__((vector_size(sizeof(float)*3)));

typedef struct		s_object
{
	t_vector		color;		//[{0:1}, {0:1}, {0:1}] 
	t_vector		dir;		//[{float_min:float_max}, {float_min:float_max}, {float_min:float_max}] 
	t_vector		pos1;		//[{float_min:float_max}, {float_min:float_max}, {float_min:float_max}] 
	t_vector		pos2;		//[{float_min:float_max}, {float_min:float_max}, {float_min:float_max}] 
	t_vector		pos3;		//[{float_min:float_max}, {float_min:float_max}, {float_min:float_max}] 
	float			radius;		//{float_min:float_max}
	float			angle;		// {float_min:float_max}
	float			reflect;	// {0:1}
	float			refract;	// {0:1}
	float			ior;		// {0:float_max}
	float			min;		// {float_min:float_max}
	float			max;		// {float_min:float_max}
	short			t_scale;	// {short_min:short_max}
	short			type;		// {short_min:short_max}
	short			specular;	// {short_min:short_max}
	short			t_id;		// {short_min:short_max}
	short			is_neg;		// {short_min:short_max}
}					t_object;

typedef struct		s_light
{
	short			type;
	float			intence;
	float			ang;
	t_vector		color;
	t_vector		pos;
	t_vector		pos2;
	t_vector		dir;
}					t_light;

typedef struct		s_cam_transform
{
	t_vector		pos;
	t_vector		rot;
}					t_cam_transform;

typedef struct		s_camera
{
	short			type;
	float			fov;
	t_vector		pos;
	t_vector		dir;
	t_vector		rot;
}					t_camera;

typedef struct		s_scene
{
	short			id;
	int				o_num;
	int				l_num;
	int				c_num;
	t_object		*object;
	t_light			*light;
	t_camera		*camera;
	t_camera		cam_base;
	t_cam_transform	cam_trans;
}					t_scene;

#endif
