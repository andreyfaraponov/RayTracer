/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   scene_textures.c                                   :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: vkozlov <vkozlov@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/03/23 11:39:56 by vkozlov           #+#    #+#             */
/*   Updated: 2018/03/23 14:19:17 by vkozlov          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "ft_rt.h"

static int				set_rgb(unsigned int r, unsigned int g, unsigned int b)
{
	return ((r << 16) | (g << 8) | b);
}

static unsigned int		get_col_by_i(void *ptr, int i)
{
	unsigned char *tmp;

	tmp = (unsigned char*)ptr;
	return (set_rgb(tmp[i + 2], tmp[i + 1], tmp[i]));
}

static void				load_texture(unsigned int *pixels, const char *path)
{
	SDL_Surface		*sur;
	int				i;
	int				size;
	int				k;

	i = -1;
	size = 256 * 256;
	k = 0;
	sur = IMG_Load(path);
	while (++i < size)
	{
		pixels[i] = get_col_by_i(sur->pixels, k);
		k += 4;
	}
	SDL_FreeSurface(sur);
}

void					get_scene_textures(t_main *m)
{
    int i;

    i = -1;
    while (++i < N_TEX)
        m->s.tex[i] = sdl_create_image(256, 256);
	load_texture(m->s.tex[0].pixels, "textures/scene_textures/tex1.png");
	load_texture(m->s.tex[1].pixels, "textures/scene_textures/tex2.png");
	load_texture(m->s.tex[2].pixels, "textures/scene_textures/tex3.png");
	load_texture(m->s.tex[3].pixels, "textures/scene_textures/tex4.png");
}