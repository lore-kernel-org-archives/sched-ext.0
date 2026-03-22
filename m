Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEFE13DDAE
	for <sched-ext@lists.linux.dev>; Sun, 22 Mar 2026 06:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774162666; cv=none; b=K+gW6/ARBUXhi2E9+DJF5KSWkaDQZds4Iz4pvh/ynP9YBwygbFjm6yM7QoNAFaAfEsmgG5XLMAv+tAW5t1V4GAlGGGE6JhGzsmwAryciFBIYx5h+GyYvkZAqpjOg9h5jnGlwZ6KpZ3NiDBBOzXJ227J1sThlHEmatzQfAfX08qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774162666; c=relaxed/simple;
	bh=Q0udf2z169WVaIz119eFU9ekbZ3DDGE67tFQ3I72DPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A9ZUTHyJTCMsJC9cbWA8wljy165nIrLrVGTUw2LgorCe0kpDhONmWRyaWkPIjSlsng/9fsBpy211ZlCifbYT7130EC8WGqOKYmbR6d7sVWKDgFnlv94ZBHcRKf+gkCIC3VTNFeRlT9IeWTUDLstlJ7ktTzIVaVTkN+ZR0N48/tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DKQvFqW7; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKQvFqW7"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2aaf59c4f7cso15468405ad.1
        for <sched-ext@lists.linux.dev>; Sat, 21 Mar 2026 23:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774162663; x=1774767463; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HgBuk/oO25FW+6DFTD4Uzxp6aOOmbequhHways0qcMA=;
        b=DKQvFqW7AxQo53Qfp2CNV3p+bem9znMtibNk8S0jkt1zwjfKkBVJDXwIRuTR30kEtu
         ewXb4HFxJAl5sfAoBXtzlkaEcjLOGDJIoQo1GlsjlXuEhuLxSWEExxNVMjzDyXyzlfqs
         53jBnv0KKF+8QjHupXFfVw/7FjDN3fxbC6JlfAzblnBLw25Ko7b76CC3qLB8+45NArxl
         pjl8/BkUT5OPY8JedsYWpzf9i4mGlz3D0PFJPlthrHl4QqsMnCztIZK/kI/2K6y2b+ED
         4WgWjLVj+vZhVPg3KeLio3ymE+TIfAQ1YYwkXfcNGZzijHYRHiXKui+EzYna/Pao/ZGS
         0nrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774162663; x=1774767463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HgBuk/oO25FW+6DFTD4Uzxp6aOOmbequhHways0qcMA=;
        b=JnVt4+0Tu/2WYYwEzr3Zkf7yTY1en9/FHpYXvy8F3L7oLJNkvyddRnEZJnAUib0IIv
         qvvJSNSSCvRXu2Q6u1PCdHvF1ypouhWFOEb+8P9eMYlSLHzxI7ywkupfqdm2BUt5/W+P
         egKDEKNCQt06ybK6rQgDJMUVQlrTttz7IoXdY7VjCZL/qDt7mp8FIGS3XV2A76p68JDn
         uCSDk4VrSqF4uSEIQqniuLuToI1JzqXxQOoBWh+R5lQXCuadnGu32XSTjNjZIUc+SKZ8
         H/wS8S6ysNVBr9RtKzgQ97wBqm/5/vAA8mOtSIGpI0QtfNgb3dDkIJF9aPhTvZVvLoHI
         HE3g==
X-Forwarded-Encrypted: i=1; AJvYcCWpt1Hw+FodPjFjRhkA9SZQrqk0XGyCeYO23Hx3XotfuF/syKORchmBmjZKfZ4+2L709pZk/+w5bc8=@lists.linux.dev
X-Gm-Message-State: AOJu0YyVPLfyOhEFe6l8RhXsKg/iIE8CJVhl9szAbzA+TXhCUmuVmGKV
	77iB9IBzWclb1AieY8H+C35hlZEIyxdV6BINfN7ge0pmpF0Ya5TZaOEQ
X-Gm-Gg: ATEYQzw8vUnvNg/YbMdLTPowR1aoSzvTP4vyvMv+lnTUqtR82T1VngiK5JevGNRR0sy
	V/YFZv4XdIebtta+pFLGUC4GB3EkvGX/dO4QKBqkBe28nxHFAzBzgbto2rtK/xaGDwaG0k5Hrx7
	acz6DJKfGFzMixVnJZ3LA9XWlIdjczq9Ae1Z1416T/fCu8d8i8I/1DuurgYlTBTW9ZfTkYKncLC
	/GIe/kgV3QFK+I4xVt1JEOZc2qweUuK1pWOv4K/X3VkegVRAUeANP1F5OhKaxuBu+tfPbXBlFkP
	G9uJrtRYRVMzc5dqTPN5kGtHrZS6YHpbEpv7f+NR70tkuxh7YteNqKtPqq/KhnAkaVqSkT894Cx
	CdUGdXsmkIvOtUtI92cru9qUZHgGqTS7b91aZA4It4/8kWm+J/yYGPE9y50+dnlDbeNfxKvq6h7
	fejLufyV45MQ/Ypc7lwDzpOAt77af6
X-Received: by 2002:a17:902:e5ce:b0:2b0:59c4:e9dc with SMTP id d9443c01a7336-2b08271d4ecmr77958055ad.22.1774162663183;
        Sat, 21 Mar 2026 23:57:43 -0700 (PDT)
Received: from eric-wcnlab ([2001:288:7001:1099:e49f:fa98:a4ba:8111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0836955dbsm93526315ad.72.2026.03.21.23.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 23:57:42 -0700 (PDT)
Date: Sun, 22 Mar 2026 14:57:38 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 sched_ext/for-7.1] tools/sched_ext: Add compat
 handling for sub-scheduler ops
Message-ID: <zvvsqqz5bm26rahcne2zcxqdk7lhuttk5b26zh64znotuoipqp@uvs2gmswgby5>
References: <20260322063546.304416-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260322063546.304416-1-arighi@nvidia.com>

Hi Andrea,

On Sun, Mar 22, 2026 at 07:35:46AM +0100, Andrea Righi wrote:
> Extend SCX_OPS_OPEN() with compatibility handling for ops.sub_attach()
> and ops.sub_detach(), allowing scx C schedulers with sub-scheduler
> support to run on kernels both with and without its support.
> 
> Cc: Cheng-Yang Chou <yphbchou0911@gmail.com>
> Fixes: ebeca1f930ea ("sched_ext: Introduce cgroup sub-sched support")
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---
> Changes in v2:
>  - Handle sub_cgroup_id in older kernels (Cheng-Yang Chou)
>  - Link to v1: https://lore.kernel.org/all/20260321102036.58734-1-arighi@nvidia.com
> 
>  tools/sched_ext/include/scx/compat.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/tools/sched_ext/include/scx/compat.h b/tools/sched_ext/include/scx/compat.h
> index 9e0c8f3161e87..039854c490d5e 100644
> --- a/tools/sched_ext/include/scx/compat.h
> +++ b/tools/sched_ext/include/scx/compat.h
> @@ -160,6 +160,7 @@ static inline long scx_hotplug_seq(void)
>   * COMPAT:
>   * - v6.17: ops.cgroup_set_bandwidth()
>   * - v6.19: ops.cgroup_set_idle()
> + * - v7.1:  ops.sub_attach(), ops.sub_detach(), ops.sub_cgroup_id
>   */
>  #define SCX_OPS_OPEN(__ops_name, __scx_name) ({					\
>  	struct __scx_name *__skel;						\
> @@ -181,6 +182,21 @@ static inline long scx_hotplug_seq(void)
>  		fprintf(stderr, "WARNING: kernel doesn't support ops.cgroup_set_idle()\n"); \
>  		__skel->struct_ops.__ops_name->cgroup_set_idle = NULL;	\
>  	}									\
> +	if (__skel->struct_ops.__ops_name->sub_attach &&			\
> +	    !__COMPAT_struct_has_field("sched_ext_ops", "sub_attach")) {	\
> +		fprintf(stderr, "WARNING: kernel doesn't support ops.sub_attach()\n"); \
> +		__skel->struct_ops.__ops_name->sub_attach = NULL;		\
> +	}									\
> +	if (__skel->struct_ops.__ops_name->sub_detach &&			\
> +	    !__COMPAT_struct_has_field("sched_ext_ops", "sub_detach")) {	\
> +		fprintf(stderr, "WARNING: kernel doesn't support ops.sub_detach()\n"); \
> +		__skel->struct_ops.__ops_name->sub_detach = NULL;		\
> +	}									\
> +	if (__skel->struct_ops.__ops_name->sub_cgroup_id > 0 &&		\
> +	    !__COMPAT_struct_has_field("sched_ext_ops", "sub_cgroup_id")) { \
> +		fprintf(stderr, "WARNING: kernel doesn't support ops.sub_cgroup_id\n"); \
> +		__skel->struct_ops.__ops_name->sub_cgroup_id = 0;		\
> +	}									\
>  	__skel; 								\
>  })
>  
> -- 
> 2.53.0
> 

Looks good!

Reviewed-by: Cheng-Yang Chou <yphbchou0911@gmail.com>

-- 
Thanks,
Cheng-Yang
