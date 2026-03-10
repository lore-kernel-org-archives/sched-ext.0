Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1AD2749D5
	for <sched-ext@lists.linux.dev>; Tue, 10 Mar 2026 05:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773119895; cv=none; b=mTLganu8AV74ayj2DKGU4lcMlTee4biH5lusXBN093E8tJGcMkLXGfbLg1Rkk8TxCqCKdfgUCumX3bm8mrpVIjVX2+6HbeuXsiCmzAR/vvCSQn3zDW0jCw3RpLoSDmFa3BM2gIVIWYSKk3evhDRI7WrmSiOrO1sFJm6P+FcHwKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773119895; c=relaxed/simple;
	bh=rxfp+03fMbTYiK3pbRnRS1ZWO88XGvI9pQPiGu4XU+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XjRLfKw77zr48oTkyl36IAomrU6EkWuY/mJ+d4eYv6VTRhFiUM7L4U/gwkcWVFZjwYk+Abn7D9sb6iN410hyX+yKJyBgkGev/ouXMgTcppnnPL2z8wCBYRoFgjzvQuZVk3HWcQvEok8w3QptTGCBlAX88gUksbbb5JdtckSG5vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cMuutSM+; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMuutSM+"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-359863611faso3703468a91.3
        for <sched-ext@lists.linux.dev>; Mon, 09 Mar 2026 22:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773119893; x=1773724693; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KGrsW3qkTSOjOmuBx5WqE8ecq430lI7YHIDWamEVE6s=;
        b=cMuutSM+nGomifloaYOQ+2zC7yAw1c7DHWqesBmLHteDarURuc9s+6UJovkTVj5A+3
         XgMBDEeT0QeiOj30KbZhVrVBsBOUlHzHHpwfm5tkfwt11LlwQecMYmfCHi416V4VKMVs
         cmc9PlZDt//6zX9SF+bWCoxDkaLWz/unU5CpI9AvuM8E579HgUNjfnxE7jwHQ2A1ilQL
         H3lrobKCDcfEd7T/rtQ9FE3L4re4tULJNgnEc3z16eS3pksQUXeF7DuMs7O+p0d8VE7F
         G/JLgqUP0f307CWPFSrzjQHxBDcDYp0o1qyBZqsGeL/UYN9VF5CgiG0pBTae8ON5+8AE
         Nocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773119893; x=1773724693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KGrsW3qkTSOjOmuBx5WqE8ecq430lI7YHIDWamEVE6s=;
        b=viYtF5cfCQ+dUvmWd2UaDoPos+P8uw7xltGBAZBx3IlVL3V7FO9xCd+tzPwtHIrTB8
         Kp2YKz4Qa/FQKfbhoYwfugkpW6+nS6F5RCUs0WZjhd91Y01PbjMEnrmtgLIzZKlDOYXL
         kaUbNXvjlOvUuHllJiAXtr91r9npUnmdv+paq5LEz2HyVs5oSATCyPEdZqdgQNtw9N7T
         bkLw+lyJIrIfHuINPL2a1zZTTu1GpKWw4JsL6H1h2RJsfLhaRW6FrWM/3lMLsEBcgUQX
         awGx+gfYSZIDF4Y1rQqWZ96tp/eB/3+6r0mPFigAM8YiK0XlR713tNJtEVaw4yI4EtzS
         NpLg==
X-Forwarded-Encrypted: i=1; AJvYcCVVh9/6PpJKjLQxSMGaYzl2Bi6lUViBq2cyCTpbVl/CHmntPSo3myfgWj++bDicQjL1tG8GJDO8I5E=@lists.linux.dev
X-Gm-Message-State: AOJu0YygtnbqFa+qme2LTpelMdeSrlCmYDk6xJfN+vaf7qzsFK6iAnK+
	l7O5LgmJSRLeHfLsj0XST6jyCqUW1o9qL5oBDHDbJx/RXwrQlbYOhg6c
X-Gm-Gg: ATEYQzyCc2gHObq6VBMom8EMAh0Z/2qpie+07tEQPnH7zHK5+NAWYezSJjChNTR5asO
	2IajK/dX7RNOAykAs7pCjfwBk9YEWheDxHPyMYVaphxhKnceNsHfsj14W8XkXCCxCkuGWTnt4N3
	0R7QcqSLEirtzTPbegsYIyHRbns/YVF/heGOKgB2js8B+YapXT1vpjBp8XsbMRgWFIE0pbs0tHT
	6RTv18ZCd1PGfz+t+JM/t4mJ/yWokl3wbSbEJ7K/50Ky437sS1aBMPLOMDAA1Tly8Gel4DnaNyJ
	tOhL4jSLbDXGvwlvPhCm+tJnNqQtchwNnfrdElInOF8JqYbzMSOxv+7xISi6Ith9RXRmuK29QZl
	9VYzu1UiM2rWKBZ+Ur9tBXS9AIDyptkHh4MymJSrLLDdk0dato+OysjQDpQVemXtvV/noDH3Y2t
	26gQZgwPeviMxRTlpoZVsImL4KwSZ0zDFEcVJyD940GizDIzF+oqrD0LZNdXVYsgPyfy+dMeU=
X-Received: by 2002:a17:903:288:b0:2ae:807e:ed28 with SMTP id d9443c01a7336-2ae823ff70emr135018165ad.6.1773119893252;
        Mon, 09 Mar 2026 22:18:13 -0700 (PDT)
Received: from eric-acer (36-225-72-126.dynamic-ip.hinet.net. [36.225.72.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83eb021bsm129379805ad.41.2026.03.09.22.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 22:18:12 -0700 (PDT)
Date: Tue, 10 Mar 2026 13:18:09 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org, jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH 4/5] sched_ext: Fix scx_sched_lock / rq lock ordering
Message-ID: <aa-pkVJ8r3Y6iXn8@eric-acer>
References: <20260310011653.2993712-1-tj@kernel.org>
 <20260310011653.2993712-5-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310011653.2993712-5-tj@kernel.org>

Hi Tejun,

On Mon, Mar 09, 2026 at 03:16:52PM -1000, Tejun Heo wrote:
> Reported-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
> Link: http://lkml.kernel.org/r/20260309163025.2240221-1-yphbchou0911@gmail.com

Just a little nit, this link is invalid.
It should use the modern lore.kernel.org domain instead:

Link: https://lore.kernel.org/r/20260309163025.2240221-1-yphbchou0911@gmail.com

-- 
Thanks,
Cheng-Yang
