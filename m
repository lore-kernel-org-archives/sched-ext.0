Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B377B1DF248
	for <sched-ext@lists.linux.dev>; Fri, 13 Mar 2026 01:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773364959; cv=none; b=DrUTqm+7bJDsYtDOIsg+2Woo8FASokEx7bwl9ZAsMRRJ+dlL4idL4So0fE9axfRT5luD990O9XvSjWVXm7yX8W5ftogujsndB5qyNJECpfkM8zz45O61IsyESvIybGNF08PEoad0glkoKVByqeyc1HhIUaKC2OC1kiNvcwgxAj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773364959; c=relaxed/simple;
	bh=S7s+E2PzTdUk5MK6iYimu8+oXGdZpi3jtSFFszLBfEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bO1jMQlo6zOcO0UOAlkS44zkrRXlKq0OeBjlYkybm0SGADeoFDnljJVmVUQwaPdZtVoNBlXgdeefy7wR0C7QcjgRWy8Ad0vJbAgL4H5PVt990bMVy/xuNaCzZkPuE0ATu5QHmyYJv6PplmoAFZ/xE9s/uppuOtMl4aJ49/+QQnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pl+y+OGi; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pl+y+OGi"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-829781b2b01so1129556b3a.2
        for <sched-ext@lists.linux.dev>; Thu, 12 Mar 2026 18:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773364958; x=1773969758; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p1qz7uWZq31kUxpd+jaV9EVh0vAAxHB2gsIYXu3Io+8=;
        b=Pl+y+OGi+uCmjdZet3GcJ3Fy0MGelOJTBIVqNeTGAZQAgzrPiOMNDVv6qzVuF20uJQ
         GDbqXAqEbINeOzDRLcMlkc3+WpCRDiPdowAaVygPrr4cJ2lsKWSQlkTp7ijKhq1jfLjH
         tv4XWWE0btvh64i5rks4S/NJxecKaOMo+XiUh6fyTZI2K1bMd8mN/mmkcq9tlPFRvtEq
         pO3HjW3R56KrJwlq1GrlG+rX5cqUoaujdj9+tKfOg+CDe9q/ACA62ghhS/EfUcabrBjI
         RhVlTE2SEqmLlAuTM9iccZg6elR0VqMx1ZnDezL83UCYmnLPFNM+uFlILbHr2rXqALCt
         J9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773364958; x=1773969758;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p1qz7uWZq31kUxpd+jaV9EVh0vAAxHB2gsIYXu3Io+8=;
        b=Iix6ppHLYHIqCy7nMXLXUa8eWLxM7YjhF/VKRpBY/RVIZg80y/ozrRweGxGJMWQq5f
         NnCGYCb4EK71KsNDkhg9mW60qlFUqP+k4U39WfmbZgPlCT+em5UmzDi4BffqHgG8FCFJ
         TlpKpy27C11cwL0osbucY9mEkN0bmeQdhy4pwNlH65x/uLPrQ6583qYB/SX0uq+gG2Ts
         Q2y62/TBioHi4ZZY8o1EyaG9Z3NE73SXbcGFX66BRo4Exxrdy00ksmNjq8RdBKuq9Xwa
         OCJtz7xzSGIr1JqngzBdq6z9aTfrcvrqwnjIUK9fMsKTK4VnLUlPe3cbcygfX7WMQ8hs
         ff5g==
X-Gm-Message-State: AOJu0YwYyyU5Lbcf6CxTrnPUp52OUFz7fXh9F+2l6HE2nz9AMbFqDvVr
	M8WQwOoYgaTBka8iIxsnMOm/ILi4pNJE8y7VSZo9QhYqVxIqutdqkfes
X-Gm-Gg: ATEYQzwD8IiXHpb7WXTsrVWAoDxthxRQwJHHwZnds7FRgOrx5bVpsqfKFReDVH8+tG1
	OPvgSCS2ZIbnIubzQDhq9Gwy4rLvG+daJrlCO2efAVo4mBM2cxERtMk6ayVkdXV6ClvV6NqAoBY
	nECkvCaoOqA4ZhgsWq5+r1VjM3seYMu8sSYnVrW43HK9sFkMD822fgGQZIYZIpaNQti7Mt8I95Z
	4D21GTFtEmOQpwjHDuknD/bmCwYyU28rpfhan4zQr8wfGAW0l9zWeUjBntAc7kzcb4Y399JdiiP
	2B0UFQtonTJjYOfP1Ufci5dlcFqnbnxoBW7zeOlbS2fmGKsti8M94Oj8ecZ/619bJmxlb1OGrwe
	cme2Tx0lS9J6te87x7rEgso/JJQF0ySjRdacniUU+Kl+ToMGXS7Ap0i4ZOtwg1ApaT13qFNzQKs
	0pxHBHMfuBk4Ghz1Kf0njvCKsQgzY9WVjCHZEK2oyUMu17Vgzx5cs+LcE6eIWv
X-Received: by 2002:a05:6a21:6088:b0:398:7922:f510 with SMTP id adf61e73a8af0-398ecd9db00mr1055542637.56.1773364957888;
        Thu, 12 Mar 2026 18:22:37 -0700 (PDT)
Received: from eric-acer (36-225-72-126.dynamic-ip.hinet.net. [36.225.72.126])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73ebb75624sm223877a12.24.2026.03.12.18.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 18:22:37 -0700 (PDT)
Date: Fri, 13 Mar 2026 09:22:34 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev, tj@kernel.org, void@manifault.com,
	changwoo@igalia.com, jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH v2 1/2] sched_ext: Update demo schedulers and selftests
 to use scx_bpf_task_set_dsq_vtime()
Message-ID: <abNm2tsm9_2HFOTk@eric-acer>
References: <20260312175527.1220540-1-yphbchou0911@gmail.com>
 <20260312175527.1220540-2-yphbchou0911@gmail.com>
 <abMoyauzdQlqUxz3@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abMoyauzdQlqUxz3@gpd4>

On Thu, Mar 12, 2026 at 09:57:45PM +0100, Andrea Righi wrote:
> Hi Cheng-Yang,
> 
> On Fri, Mar 13, 2026 at 01:55:26AM +0800, Cheng-Yang Chou wrote:
> > Direct writes to p->scx.dsq_vtime are deprecated in favor of
> > scx_bpf_task_set_dsq_vtime(). Update scx_simple, scx_flatcg, and
> > select_cpu_vtime selftest to use the new kfunc with scale_by_task_weight.
> 
> Sorry, that's my mistake, we should use scale_by_task_weight_inverse(), not
> scale_by_task_weight() as I suggested in my previous email.

I didn't notice it either. I'll send a v3 patch!

-- 
Thanks,
Cheng-Yang
