Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02303324B2C
	for <sched-ext@lists.linux.dev>; Wed, 15 Apr 2026 10:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776249988; cv=none; b=XARO6LgHaNbXVzbgDRNrQq2vVXFFHqeAjwaGA0i9nwp1a5/kRB2adl3psWyhU/qfYev3fEyTar8CmSEb1UczrPbJQcC6HeRUaey+o2wCBhCZldZbuWv2Nj2UQ0eudbpWl9mM9Y6E5IkDqarx7szCL/saPm4FkHJORWFeds1976Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776249988; c=relaxed/simple;
	bh=AUbxhjZY1X14Fmu9YdfCM7X81HMDFuS3DyxT/M7EsVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RFcYQqj6bab4mTgUHhsKn08vdI1Cb9ewCO+aW1MQMAoVOO6+GrOzWsxpTjmatCjbRydlC923mPd+iCjdfncyfFYXf4WTcdQdpoQI7+vN81giBXJhyZxDn1Xvn0tZEa2QlhUvVDwMv1gzxlWo1LDkTA3BtuS0ENmUEjSB/rigPeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rI9sN2W0; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rI9sN2W0"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8296dabef74so6127354b3a.1
        for <sched-ext@lists.linux.dev>; Wed, 15 Apr 2026 03:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776249986; x=1776854786; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0d2SEXnVMK2HTBzxusHk6x6tCkHkJMFw3sVLQw3tnF0=;
        b=rI9sN2W006yKNJaQKKy479L4/64fzm2vWRa6Koe2dGaaiH90ecxXHGQfWC5l44GWUp
         BSTB3VVMlNLpyJ9B4PSbnXs5Wzw+/UxMXZcEjfwsiuKaClFmobQVDvVTlwMTNifAuQsR
         hrDvg+653wQCeeBxl6Y2IOdgzeR4TVp9wX9ETOivvtKY4d1CBUyJAMxPDR7I8HjfRlB/
         ec+WoeS4Hr9NxRoNB2JSgR8MlJtFKymXjaibam5NNa0bckRyDS5+4e/ssCmuPsG6sw4n
         fLtAUnHTjAXo7ePm+snztDpzwv/D3UBrD/P6bh5NKNs2balPxVZaIGVgD2di61fHAhgG
         cMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776249986; x=1776854786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0d2SEXnVMK2HTBzxusHk6x6tCkHkJMFw3sVLQw3tnF0=;
        b=WaTR/ob/G/P290/dyFOZs6eHPzYFrw5lJWGoE3tmQxQ7HezwaeWU80TgfCPth+aX8s
         Nnx3EQGWKsnD8K0btAwgpDTQk5LJWe3b95Jb6u0sFIhaoS7Brv/z8/UlzER+Rg2Vzzmf
         7O9fS4SpjRRvaW+D+zs1KRvf6ZxHr/mOfNwptjPYFgf8QZ4CLvmh5tgJy2tpj3uTExJ5
         5ge8iv+ZpQjINh/TfaHYVLWLqic61YWNaKmJC2zGolW7wGLlBg+rBWrjuDj5ILC2QOzC
         dkl7o9Ck6YPZgqLCAbRDt+44SqX5V0ExJaL3ALsqtIrxdY31POGDOVaoGLqvoNYkrrss
         isjw==
X-Forwarded-Encrypted: i=1; AFNElJ9zEQoVuUj/Rj0bSHIETv8mEPD/EllxR1psC1lYkF7jtm9k1CcwEV9w03XlcIyUxGKpe9FGkpS+2/4=@lists.linux.dev
X-Gm-Message-State: AOJu0YzTYpIJzXd0RxqMWg9+YaylnPzZX2kXdP7S85lSPfV5mDdPtFMl
	OnIDefQEnImW6h1MMJijbNNfkVF6VhKdprVJ5G+ZHbRaRiUmm4xatYsmmSYTHhFS
X-Gm-Gg: AeBDievprIXJscKkWbmjPiHHH6ybZkcEx0RjuKnp47wBRfY92DSehgpO3gX7RCizxIf
	1xkQ2xY2MZKjGhGnCDO3jzdNPu2UQN7iRyCt6aNNT9UYd9IpMcNnyL0GuNxpyiK4+p6MAeQ1UTU
	2w84PQOCnpGBN1Equ1CzowQkuC29sxsJrZM4hO4WMmWaqKiZx3EUaYM3HCrPaGdR7RGhvviIkki
	mdgLw5RSiL7DoCOsgRjiMLHVjztdfNssy6h20xvnkO4i0Q1UxdLU5MsoQW32ZRrdShm8pglYDrB
	/CGCtjzhJvXooCJiV0TVEoDdD9/RkS5J3+UiWb/QsowAsD632ds9k2fYpQHnmzZLFL8r7qilO2D
	cMc7lwnk7OMSnDEWjr5GVP4IKJ8KoULsKBr6lUmrDbJG7DKaGCLojBBtaoJU3Uw2BTrVEarFMir
	JGfGJGGgNnBP1MJ4gzk0U3LZEXxxTR+PwiHBpG
X-Received: by 2002:a05:6a00:35ce:b0:82c:6683:b866 with SMTP id d2e1a72fcca58-82f0c1d9b9fmr21074886b3a.4.1776249986242;
        Wed, 15 Apr 2026 03:46:26 -0700 (PDT)
Received: from eric-wcnlab ([2001:288:7001:1099:49:cbd5:ab58:206c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f6707b6b8sm2077775b3a.22.2026.04.15.03.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 03:46:25 -0700 (PDT)
Date: Wed, 15 Apr 2026 18:46:22 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Zhao Mengmeng <zhaomzhao@126.com>
Cc: tj@kernel.org, void@manifault.com, arighi@nvidia.com, 
	changwoo@igalia.com, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, 
	zhaomengmeng@kylinos.cn, jserv@ccns.ncku.edu.tw, chia7712@gmail.com
Subject: Re: [PATCH 1/2] tools/sched_ext: Add missing -c option in scx_qmap
 help
Message-ID: <yyq2xc5xpdop65bvs3t7ncmqvw3ilpby75ywzv7g4gmq33hsxy@pohcz6wovyct>
References: <20260415095418.307555-1-zhaomzhao@126.com>
 <20260415095418.307555-2-zhaomzhao@126.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415095418.307555-2-zhaomzhao@126.com>

Hi Zhao,

On Wed, Apr 15, 2026 at 05:54:17PM +0800, Zhao Mengmeng wrote:
> diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
> index e7c89a2bc3d8..b5fce6dcee14 100644
> --- a/tools/sched_ext/scx_qmap.c
> +++ b/tools/sched_ext/scx_qmap.c
> @@ -32,6 +32,7 @@ const char help_fmt[] =
>  "  -P            Print out DSQ content and event counters to trace_pipe every second\n"
>  "  -M            Print out debug messages to trace_pipe\n"
>  "  -H            Boost nice -20 tasks in SHARED_DSQ, use with -b\n"
> +"  -c CG_PATH    Cgroup path to attach as sub-scheduler, must run parent scheduler first\n"
>  "  -d PID        Disallow a process from switching into SCHED_EXT (-1 for self)\n"
>  "  -D LEN        Set scx_exit_info.dump buffer length\n"
>  "  -S            Suppress qmap-specific debug dump\n"

Could you also add [-c CG_PATH] to the usage synopsis in help_fmt?
Thanks!

Reviewed-by: Cheng-Yang Chou <yphbchou0911@gmail.com>

-- 
Thanks,
Cheng-Yang
