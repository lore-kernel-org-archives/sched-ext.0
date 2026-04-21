Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8173039D6F7
	for <sched-ext@lists.linux.dev>; Tue, 21 Apr 2026 13:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776778612; cv=none; b=nNtlRzz5Tmi464OJ032XJ/7ARQGlsww/oRYLF4im6dfEK5TFvCZAReciwu3zM+/3vXiT6TCyUtx4TLEE8r118IyPqKshhWqhAazuLkFPcmiCm2IUAioVySdlhJ+LDg5onxaTxS0WhyRjS0nFi/S7HBcPq3V1V1VqRdWFhfTdgxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776778612; c=relaxed/simple;
	bh=HfC2rcAHx3L49DKzGd14vHAZZy0fNUJCCBnyc+rOkLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZKJ7j6nUdr2e0cArhzA2l5XNnr2hlBVPa2qkOOcz/uyNOSgV50Db4C0xX6S4UcfePFPSQtoGAUwlJdwz6xeTWHvrdGHbIk5Hv8/TXdMxrKV3YhiUVhvOF47nFN6GTIyRlRCeOn/whJ3G/nH6FXh0jKcGpxkCmDDmQjpKRWTTS+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y1BdfwTK; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1BdfwTK"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-35d965648a2so3623113a91.0
        for <sched-ext@lists.linux.dev>; Tue, 21 Apr 2026 06:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776778611; x=1777383411; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cICu5OuDgaUihDORDEXfRm9USuXHUFKG9LJ148MNZfc=;
        b=Y1BdfwTKfOPEk5OCInXL9dvDCrihAb3//3b5B/plSRcgc4UQwPqXQyZgppixapBOn8
         inaA+dKUMjbHn/Zf+XbDaK8JTYOvzP7XoaHuTksLtlBrRPW09YzLIafZMB0alJ+eJngx
         6ivzexqxi7LxLDt1kZL6k3cdxpNy4t7hAY1YbnjBFrUVoHZstip8Rp+1ghghTGaORe24
         v303XJsJ0Xe90lVYBJfRxf5UkC3IoqXnbvqEmrMPWN7SMK+qPVeyRugI/chNd+z6MJth
         Y5RuLtpzntBtbBPSLGly6Bkey4XksL4tveD00z1HFA8mVx5Sk0RblhYHcpdio8Fg8AuF
         ljKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776778611; x=1777383411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cICu5OuDgaUihDORDEXfRm9USuXHUFKG9LJ148MNZfc=;
        b=O0rsybADGjKbyOLqBWBHG7kQGa48+ynMEAngO4NntKXeN8K6u3WhxJQ6yCslreXdyg
         GyjP8hKNPxVhGo1Uv0IweJEijxQI4IL6K92gLm9anO5B7QeOWfktEbK90dGyqq/mUFRz
         qiFxQzYOD451UYZC5HwU8xNOCCHPHNst9Fo/uWMGOOWObdGAfKff4YfnRTKGHR9jrVqQ
         j/ezqg6/UdsJq9WqMiQ/zW7eG3FgwwaukovVqBlDZK1lJAI5PFTNCM56OQEW6qFktQjQ
         PpS1xl49D/rh+4W3Ob/1jVTSn3F4bvrisKAJ7vUkOc4mSbS82VyRyx2Pt6toIQffPtVo
         I72Q==
X-Forwarded-Encrypted: i=1; AFNElJ8LBxng/yz3+45nyvk6Qjfh7Zpqd3Jbd+ecI19F2/b8JknAwqTVQF6TLKZxYh5pEMMT50jXUK0f1xg=@lists.linux.dev
X-Gm-Message-State: AOJu0YyFllssWrmU3bVbMJZ0xo1dq4f/IrsG38UKqujJfED5sFTk1lZu
	HATDDcI5huaDMtc4rRCheqpI4raR7S1X3BF/nSwU9lnBL8n9irX1a9Oq
X-Gm-Gg: AeBDiesrg+79mcX/n97jl3pGHJ4TDrrsxZN7B/MPdq0s+SJPzxGoF50nmPAT2+XQjq3
	bJEAVC21Zh9OgVFUsA3P5hMcSZ8ske578q5mX375QViCtQOg53xCqrDut5n4MjKABQe3q7sg85+
	U88ahZDoSF1CT2QW+wqtrkv2PL1n/iZ9F5iCzLURaKFF8BYI/xLrIxzOCll55HzD2ldAj4B/WRG
	lK0xv/7Ar6HZcochvbr+olDn9Xf7guEClBYEa7xYpup1GQ+WwMgrzDeAFqd0pfSVcxcD/IoVeJB
	X7L5UxHGK+q/3/vpobykTGazcVwFTooWoh70IvzY5ic/fBbVCIjwmxdyuZ1qoW4GIazkvfTg4p2
	wPL+i6vxBVU1jg9RuAX1igoywEx76rNti1L4Dyi2nZ8tO6eb3bl4vRQMS3dYYx6G0/fsJGVOg/Y
	iMqn+dGYiGxZ4Q1D6YL8EbGMTZH5s4Yz0nIESR4s1/If2mCiQcwNou7i+anMtRBAQ7vl3TzGa6J
	6Ui/DlPg6pCedk/
X-Received: by 2002:a17:90b:1642:b0:35f:b107:f1ae with SMTP id 98e67ed59e1d1-361403adbcfmr18302652a91.4.1776778610624;
        Tue, 21 Apr 2026 06:36:50 -0700 (PDT)
Received: from cchengyang.duckdns.org (36-225-97-241.dynamic-ip.hinet.net. [36.225.97.241])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c79770587c1sm10602734a12.32.2026.04.21.06.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 06:36:50 -0700 (PDT)
Date: Tue, 21 Apr 2026 21:36:47 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, 
	sched-ext@lists.linux.dev, emil@etsalapatis.com, linux-kernel@vger.kernel.org, 
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH 02/16] sched_ext: Move scx_exit(), scx_error() and
 friends to ext_internal.h
Message-ID: <20260421213118.Gdc56@cchengyang.duckdns.org>
References: <20260421071945.3110084-1-tj@kernel.org>
 <20260421071945.3110084-3-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421071945.3110084-3-tj@kernel.org>

Hi Tejun,

On Mon, Apr 20, 2026 at 09:19:31PM -1000, Tejun Heo wrote:
> Things shared across multiple .c files belong in a header. scx_exit() /
> scx_error() (and their scx_vexit() / scx_verror() siblings) are already
> called from ext_idle.c and the upcoming ext_cid.c, and it was only
> build_policy.c's textual inclusion of ext.c that made the references
> resolve. Move the whole family to ext_internal.h.
> 
> Pure visibility change.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Cheng-Yang Chou <yphbchou0911@gmail.com>

-- 
Cheers,
Cheng-Yang
