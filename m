Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9FC279DB3
	for <sched-ext@lists.linux.dev>; Sun, 19 Apr 2026 16:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776614918; cv=none; b=i+5zQlgTHhf7CZDVyUykPqfFp3G+YhlAz42QJZKBwYQc+TlnlYzoSDQ4/RAuAElFR33EXrKdAy+BX5DSdE8IhGB5S12XNpy+I0d5w+o3sz+ZWaViXUSkyE0RS1kx0SXu9edcRQ+8IjwPgZ32uiRkQ//xEPukJCJAqJUhxtaXy6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776614918; c=relaxed/simple;
	bh=NKEaAD+3eWl4gKIG7zdM0p5hQ+JhG/r/VXWI2wvbm4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFaK3YUl3rDhSrm3UEWRstfB+SdX7YQLJQyUpBhPiyeNN1L/lojTPAG0bmH5cVuKY94o6m7jCVoRKu5WnUl3qwQzFNpmuG4nwsyVEZGJBcYKnfQDLXdKlgLHszeuJ5g994BT5OMWJ30io+V63GP+L6BOXoRhVNzi7qXI45945KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bO8pdHoC; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bO8pdHoC"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b23fcf90b2so22638325ad.3
        for <sched-ext@lists.linux.dev>; Sun, 19 Apr 2026 09:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776614917; x=1777219717; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ndJBZ7UPSsArKlwCUxRT5c8CBnik95cDzWoK3nnYb3s=;
        b=bO8pdHoC++QVr5GQ9tdmJ/nYD4jk0+aeRIQ0O29OIG8R5A5L6Q67Dn4pFpw0TVPk6X
         FLyCuPfL7h6dBEtYiDA1INB2aEovz/mbtYuMufPcLyhoPBI2ZltzUXkB0dWmrwmG2FKx
         0y/d+MzxosCGRFNhly7e+Wq+sZN6/yjOZgG+s4LeWujODw0l+guc9LdcKESFPYUPz8Za
         GtENagKXQWqvyrWWQg6ZrcA695xUsSBzwBwBc9o+oSX1f56HeCAP0sDc1TUz9ScDeEa0
         spWfqgOWmepU5G0vpz4dGsdKK4mx7x8J2YTlBIKVc3/8oZL0FfqP0S195ZOu+6CzAii4
         fOSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776614917; x=1777219717;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ndJBZ7UPSsArKlwCUxRT5c8CBnik95cDzWoK3nnYb3s=;
        b=e64suvkAXk9Y3an3hIkFiQ3TSZYoei0anO3yYo8ekD755bTOvos7qtoDE7+0esStMj
         g350PbJoTC3fD+7gAVoY0ThAJUkJnWj+AHzxW9rtnlx1PRfUsgY0usD8tZZQMtJ62FZi
         zGDxyr2XJA6TUxBfQAksSRCl0ig14gU03H+1/KcegCA4zjVB/aTu9h/vopD96iudDJFM
         CGHaOfpv+8qfGdv96/x9KD76QDblbQe40LrJR0KI0e4uW4qfbr2rswGkTrAcHcYKKxzl
         ehsm8QQJhXQHJMfOJwD08b7siduC5/yM0wGWlEMIhyL5NObxV0nr1v191msijpwpyfB2
         8DFw==
X-Gm-Message-State: AOJu0YwXUOpkuLm6K5EB6A1yu70isCnXV+/XPaKTF/qTSvQfHeoIKfeH
	fh/KG4BaI8CFrHIiI5m/TsUUmIhqmdPaiCxagSBoeJ2wOHm3VJY+ZngO
X-Gm-Gg: AeBDiev30bWiFk7FObQ7iz74++r7JMHEvuvNm9cgRj4PO67QdeRNG1rXrrokl7Mwk8L
	w+OHcz3qytLrSaVWViB7OWMXh9cqZnH7pHtWMvUlYgzc4dv5mhK3ivMbcmVHy0b8eezukqF7bhX
	5BGy0CGDhnIlN2/498dPWLv7SDO8jk/GpZcyJ2w942MNhaC/hZcaVm2YpKD6tcOShoVY7u1RcIi
	HiIDQ5K1YWaHK0sN2QyP0I+fy4x5cXofLmYhKm5yIPVDpkmOVMrIGQP3DMC2h2CPtBol6fOX3W7
	zcm70lr5Qr/9C8MaJTymc6ZBRAKTi0eUmlS5pcIQ8yKNenLU5ivAySUtd9kqDorg+kQWY45r+k1
	UUjpGCim1xKK3RlEkxAMWnaSvV1fEIMjc5/zS+odj9OUoWQEOVo5ElvcuQTJeQk/fVhaGDKp62O
	tNNdRYQ1NS7eRWyiaMLPtZ2cFMCjnZrQ7sGk8HWiXl3iPZgkzlRZLJu9o8MyFQJfCiVGxmfo1Lr
	2U6BUetZjEt/Huu
X-Received: by 2002:a17:903:1ac6:b0:2b0:c90f:44b2 with SMTP id d9443c01a7336-2b5f9e8252bmr110521715ad.12.1776614917063;
        Sun, 19 Apr 2026 09:08:37 -0700 (PDT)
Received: from cchengyang.duckdns.org (36-225-119-66.dynamic-ip.hinet.net. [36.225.119.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab3bd2bsm81058875ad.74.2026.04.19.09.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 09:08:36 -0700 (PDT)
Date: Mon, 20 Apr 2026 00:08:33 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>, 
	Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, Chia-Ping Tsai <chia7712@gmail.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.1-fixes] tools/sched_ext: Add missing -d
 option in scx_flatcg
Message-ID: <20260420000646.G9266@cchengyang.duckdns.org>
References: <20260418092247.1541377-1-yphbchou0911@gmail.com>
 <d74d5225acada39582429be8da2ff0cf@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d74d5225acada39582429be8da2ff0cf@kernel.org>

Hi Tejun,

On Sun, Apr 19, 2026 at 06:04:34AM -1000, Tejun Heo wrote:
> -d is dead code - it just sets dump_cgrps which is only echoed in the
> status-line printf, nothing actually dumps the cgroup hierarchy. The
> right thing to do is remove the whole thing - the 'd' in getopt(), case
> 'd':, the dump_cgrps variable and its printf - rather than document dead
> code as a feature.
> 
> Want to spin a removal patch?

Yeah, for sure! Thanks for the explanation, will do!

-- 
Cheers,
Cheng-Yang
