Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB3DBA34
	for <sched-ext@lists.linux.dev>; Sat, 21 Mar 2026 17:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774113450; cv=none; b=lhis+NqGUtLaBjWhk0qrEb5tfldS8yCh4Yrf56PLw7xvs8Q+kH3frbaREPMlBT2zbYkQe2KWeAKWBPVeWNqJqZpJ3mVJhxWAVcEAjox9eMIb9bK7Gi5HzOsnEA3V9+4B0CUzGZ2OeuZB0hyE+CRxvyJkks8N6dTThUmjFsF5vaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774113450; c=relaxed/simple;
	bh=9qqbOpFP+aZTn7RnpB2ERnEi0gep4QaIOgb+sPds3Wo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tmXJ2/ej//2yO3rGYOlkoNEcx8X5sVWhkJOoPWb0aOlEp42kCg5Ze7jc9b8tDSrlJDwYXMMyhxbymdi1a2jPq96KItuatYtD6iwkxhYowxnFUOhZXTbJRQRdm8Cf1foNWsaz5RGBcoqvr5dCFdVH7j/YrVQU5P8Q9nGlpWb0Imo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nZaYEHTV; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZaYEHTV"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c7393536e53so978964a12.2
        for <sched-ext@lists.linux.dev>; Sat, 21 Mar 2026 10:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774113449; x=1774718249; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tNvxbi7XKpaTg5YB522tZr7JsGA8UnENDgko0akTijE=;
        b=nZaYEHTV1CUX2Sa8IleNJnyZSkmz7ebB2bw0AysvmMz6dqzABoRRI9nyOEF2Sr9Ds5
         4gUt2rWUV6KBGY+dADCD6Q5xHYQExEj/8B3SvkQ69tSI+PpdchjXkPCMmRP380jbrxms
         ZCVyszqQya/9NIA+YyjvMLxRBczX8ClC86kIlgJMYlT+YTX9rtUjlRo3jm6FyuCQ3RqV
         gLXpWi8NYfH3iRk12RswjKFbQ2hfiWXkjkEVEgfli65Gk27oQBhsW+h/rKw8Y9z1krVX
         8SKgHbTheUz1/ntDrpi0mqGYHGu+1aB1s5y2KCdnoivgofpLVscAm07rVuSqhHRr7l5c
         05bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774113449; x=1774718249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tNvxbi7XKpaTg5YB522tZr7JsGA8UnENDgko0akTijE=;
        b=gDS7z2fZg+X6j3//3BDEHyIZrUk7WvU/dVGsKrFwA7bXbD0ccTIoOqpMqSEz0fFryh
         R/EnjHwO+7jc7Olmds/apgNunFbbZ3nqOXrXqav1O19Xrw+yh7K3PnDLcqLS1kL2c//2
         5FSsvXDWZNXc13d7ZlYKlPm74+cBUZh+FNqyK84WEnbqqL7q3dtJasxeMtORP4mFiVTs
         ZWBPorp6GTGFhJXVGx8P/SxZ0ewhK3j80W/SIs+R6thnADASwmt047U27RR3L1Q+Ojxx
         c6ECfA8NCl5JJ38yjPCJTMfMGArgTaJeQhNzeIEsM4M5sWlvlxMVinASmk7LEQNM3Jk7
         zbIg==
X-Forwarded-Encrypted: i=1; AJvYcCVDqlyrcjAbQmNseWkYRQ1xPwrqQ07XzUBjp5Cxt5vKjGOq6ptRNL72QygIM0zb+wUEOj2en3c+mX8=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz+pjelUKL/y0Gfz7i929O5OZM1LGIzpwcg51+/CdmutM1nDVEp
	5eq+dtisdrylyEP7myntW3Z3jgqXYufTt6oJMOvYzK7xsD9rsM7D7sKt
X-Gm-Gg: ATEYQzzJPIucNXZDFVjH3rxR+LfxnV6G6+AdLo8Zisy6kl0pMjtwvUr8ShMpqtDiX8q
	2pIj22zAQGUx0+5aZf3u5dK7k17CBvPhAfRkfY8q2pV0lWV8AX/doS52dUuaidfvc4xMbvMMuul
	L3Xh3YYAVnnPPEEqK0YLzNpU+XQECDn3HHTArpoIvpsniuWtegPnpt77uw3yJanunfTbf2Z8ioN
	Lb4UM6CkDDqPlIkC+U0xdkw+QP2yn2TsAZgtC2++sSAu2CE4mIAai0Jd6txCwo6k5V77UuQmP2H
	ftlWP20rMxDe0MXz8qdOeZWLd9RCEJfmVuyiJl/U3LGN8A3yLtlXdUzcu7jNRCg62yDsHj9UQ0I
	XV30hdfzYMDcCbJj+XfVEIDXbHQTgadRPQ92DO7z17N2d3e8g7XC08zfTLpTHkAOnvVpG0zUWWo
	IwBeUrXPCK9QQFfj0W3iK237u7UP71KjJ/3XxrPu6txhOyw/ZZOMoh2Zftv2KFIY6nO1U0hJ4=
X-Received: by 2002:a05:6a21:9983:b0:34f:14d6:15f5 with SMTP id adf61e73a8af0-39bcea44a69mr6274854637.29.1774113448926;
        Sat, 21 Mar 2026 10:17:28 -0700 (PDT)
Received: from eric-acer (36-225-109-46.dynamic-ip.hinet.net. [36.225.109.46])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c743a801b79sm4066000a12.3.2026.03.21.10.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 10:17:28 -0700 (PDT)
Date: Sun, 22 Mar 2026 01:17:25 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH sched_ext/for-7.1] tools/sched_ext: Add compat handling
 for sub-scheduler ops
Message-ID: <pm5crn42f65l62neqyonq6duzhdacnilhgi27y7fr5ytk2izdr@s257t2vpf37k>
References: <20260321102036.58734-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260321102036.58734-1-arighi@nvidia.com>

Hi Andrea,

On Sat, Mar 21, 2026 at 11:20:36AM +0100, Andrea Righi wrote:
> + * - v7.1:  ops.sub_attach(), ops.sub_detach()

Do we also want to handle sub_cgroup_id in this compat block for older
kernels?

>   */
>  #define SCX_OPS_OPEN(__ops_name, __scx_name) ({					\
>  	struct __scx_name *__skel;						\
> @@ -181,6 +182,16 @@ static inline long scx_hotplug_seq(void)
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
>  	__skel; 								\
>  })
>  
> -- 
> 2.53.0
> 

Overall looks good.

-- 
Thanks,
Cheng-Yang
