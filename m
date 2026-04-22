Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4FC273D77
	for <sched-ext@lists.linux.dev>; Wed, 22 Apr 2026 16:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776876410; cv=none; b=GvPZFT73bT1sv3H+SDjCvj15g3CG/4/gTNs1FWE7q6PA23R49s3Y9MN9YGfJQQ7SDhoodJyy0n9jURc/K7PfalfBmLsrtu5kW2yRwlVCctPxKWMzIia/MjlFIqsW8kRysK3HXhmSrbxZpigiP0PD+YASTrwot7ekQg0XNvqHwFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776876410; c=relaxed/simple;
	bh=99zbQyaHlkbKNVHdYINy1JrPLVv4+cbKDfY0jQlPFVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i7bp+GUq2Fv6FggESyfiKPA4xGUz31mU2amt4TyZ0kWMYOmRYK53tgrQ42qUOPsH7iu3U8DcEJaZuPE9ZImaka2nFzYNuZ9V0Lvbt2uzfaNR1j1CglJ7w8LwQyHADx7nCOo+MDnaz2QWgjGc7x1IRDzJzoYtlBw9hU/T7aBa6wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QyvjtvP1; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QyvjtvP1"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c736261ee8dso2124398a12.1
        for <sched-ext@lists.linux.dev>; Wed, 22 Apr 2026 09:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776876409; x=1777481209; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MTiFznwmxuxHJ7p2vsCeECnBXbTkoHzLfMOh4vRan8U=;
        b=QyvjtvP1yusP+NVpegTiyEsmDF/+/EVNm0B81n13ZY4Mv7nci4/YEB8sJX4GX/HoRe
         hfSLsRrUBR4DjnlFLwyE5slqn5t8t6fLd+pZVapzPWbMhZw9O4a4g3qR3RMafa5yPvo0
         XzV3ODvHKpxiAn6zwH9Lrvc73U916RhoDWItEAmgGLuxl9cRrnjc/G+/bFVexSj+1EXo
         eILPU6sKqLTYgMrrjoToXPXF6mMG339bh9uDNXx4xdUmTEOWIVS5NzUOep1iY+5DTAWt
         jcqbSDlVeeUFnxVXxXWxarylnwZ/GPIKngkcNzsYTNQ/gnJPTN6YKtvRNtAx7d2CRC+l
         M6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776876409; x=1777481209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MTiFznwmxuxHJ7p2vsCeECnBXbTkoHzLfMOh4vRan8U=;
        b=X3rMiqGfIqZsfhLYB8zpA+Usr+nxqnRSMllCDCuzgHJveP7NuFB0l5cWKKin9xoViS
         8bru83YksJdnbCSn6TxpxCxu53VWw6zHjzfh8hYZ0H2TC3KgUNa6mjxa82RI6UBge6k/
         2FkSdSDRmRO44oxG6G+ety00+zNhytRFDBzgoA6PwtCnLDOLLmqSLaYDsQCL9yYlfPXz
         ExU2qhq6TM20uu3OvXBgSFi+NH4QHunDwXCYKvpWulKgTCOboPP4b0eWX17CPJvjlp39
         T1aypd/1fZy7a56tJ5tN9zVW0baRvqrguGWbLhwZyC8r7rd9Li2RUH/OXLsWDjA+mIOD
         skGA==
X-Forwarded-Encrypted: i=1; AFNElJ+Up3AucnS9S76VRQ72YIOIbXeakNKIpaBet5BhXlvZJNVJ2jCHjcZdXg6S1s0dE9u8C+AXdqE4TZ4=@lists.linux.dev
X-Gm-Message-State: AOJu0Yzb5NpdWHuH3BW9ZL4pUkvrCMLXJ1DtNlTqLHswc/I2bL9y/ZLd
	xqrrPA9f+HZq3dg8JZLlvmudN2ms7KlyjJgVd3Zg1f/NnaipufN0OHmlKl77Bmnu
X-Gm-Gg: AeBDiev3DzINEBNB8+iTunjULF5CiwthCOrHFUozKsh0ru/lI7WySkcb5BTRg9e1t3L
	uXz2ub/VBgfDbxvvrUOEaI8l0yhSQVzr/luopQ5vU1OYNk23rtKsp/K+wm1f7kMZHRCnvmWjreX
	FQL4qDv71Uley4p51YQ2dJ9D3pE8STnAiWIWNrGJpB0o5O+gkbPTf8u82k5WtcfjfqZsAB2/+jr
	FwBLnXykqpKT6mbrxfbsi0h0/hu2OUZWo6YB9+rKh9WbawLN0TX6GgWqb4/OQpmA0X9cUvUieWy
	0njdTRtH8L0g8Z9bfreBfjV0Ui0L+GQ0lCM9T0dHuMbOG1q9ll1zCCtq2xzjewyqPNmNTTRfhFY
	lxklTlJ2qLTtuanPy4o0Lrf1e3DszbmxINKIjwHDbD+qrnla5zKatYdPQxMiu6h50FSNz47GvY1
	p2IA+S0NvSW6SkHNBodlBy/ac6Phdirs5O9GU5EGS9Wq322Ngt7qhXFYXFUlgpcUjihlH9km54X
	vnyNG2mm0QOCXQNr4ftEGDxQ+E=
X-Received: by 2002:a05:6a20:12c4:b0:39b:98e3:6a30 with SMTP id adf61e73a8af0-3a08d92f367mr27793102637.51.1776876408812;
        Wed, 22 Apr 2026 09:46:48 -0700 (PDT)
Received: from cchengyang.duckdns.org (36-225-97-241.dynamic-ip.hinet.net. [36.225.97.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ebe6439sm17842971b3a.41.2026.04.22.09.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 09:46:48 -0700 (PDT)
Date: Thu, 23 Apr 2026 00:46:44 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-man@vger.kernel.org, sched-ext@lists.linux.dev, 
	Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH] man7, man2: document SCHED_EXT policy
Message-ID: <20260423003214.G1987@cchengyang.duckdns.org>
References: <20260412181743.276652-1-yphbchou0911@gmail.com>
 <aejvcpOKmAxCnJQV@devuan>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aejvcpOKmAxCnJQV@devuan>

Hi Alejandro,

On Wed, Apr 22, 2026 at 06:02:49PM +0200, Alejandro Colomar wrote:
> What's the reason for this weird formatting of the source code?  At this
> point I wonder if this was generated by AI.
> 
> Please take into account 'CONTRIBUTING.d/ai'.

Okay, after reading the AI policy doc carefully, I've decided to drop 
this patch. I used AI to help with the formatting since I'm not familiar
with the rules here.

I didn't realize this was strictly forbidden here, my apologies :/
Sorry for the noise, and thanks for your time!

-- 
Cheers,
Cheng-Yang
