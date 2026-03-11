Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B859231A3B
	for <sched-ext@lists.linux.dev>; Wed, 11 Mar 2026 16:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773245535; cv=none; b=oEwo1Foe4FAfMKCbBwh0y1O6gDOciAyqp11bQY8J8clNGTy9hLmF1G0PpgiDF33Lug19RTDlIUd1UKch8lH9Ol2cVv7CZB8TtZppYgBxMZzcaB7BdVI989cwJ7bIzsB2RFNQ1USxVF1PqLW7yNcRZOrFi5vbeJygn8uAgsj8Kh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773245535; c=relaxed/simple;
	bh=SKlG6oM1u2inOLQD6QL9IfeN7g7BL76Mhd8qy2raQSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K30WbA12lTQT63i5/pmGefxgJTBYQSMo1DklsX1yyJ6dolZsX+K42oVyjw0WgXAEigmiShMSl0qZe6Nu6s/EjEeckD7VyzvSjTpqG2UPC0ZnHdwOElz9MtjS13I5b5zjzTF6Gp1bkKu9+R9RnujsVgZZEueV8BsuOd44kotcbj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=STX5jvO9; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STX5jvO9"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2aea68839a5so805825ad.1
        for <sched-ext@lists.linux.dev>; Wed, 11 Mar 2026 09:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773245534; x=1773850334; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nBJTQw6BGBmKG+6ocGkMWQ4+MHex2fHzaAzPPSYqPwg=;
        b=STX5jvO9rArpxEkYVK5mpZmhP9/OJQf57yPHCJwQ7PWVP9eQDiPKZr/uuGbeFAH1vU
         OmLKmAGKjAJBlnQYxK+ags6bRnLMVZIk16Xmasr3tkg7v/uH3j9bz5qkMZ/Fu7+ZIdud
         GtJeVulP84vUHE4vtpFvGgj/qJEYleqAFa7OUAyDMAYFVF0Y9HazzdBiGtR8l03bQNYe
         8ZJSQ5XeiCjAQzHOhfzgFvIUnmq8X7YNo5RChbhfIkyAjnpAVCX0FpME4EfHMc1a17Y+
         nmUC6hW4l+eZ9A7zLf3JVQze916od7iy74W/U5jkN+NL6YI0xiCbH0Q7dMmMRSXd9E9j
         qy8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773245534; x=1773850334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nBJTQw6BGBmKG+6ocGkMWQ4+MHex2fHzaAzPPSYqPwg=;
        b=RXXCqQXTuwOV7oZCxZWvEDxB1yNW6HxTk8GLjoO1j5xIHKvcZQP2DBZCtOnd4CZeEb
         uiNvZNiCm7c6R1zc3Yc34sloU2sOdOTHRIlPLCd6R/3ERa2EgXTivkO9jdMbVS75xMai
         JLwmSCRJTxyFjqgI7UZ3VtsT4D/hbUpmUqsUGDfQEy/a37IRJG5XWqEhgs636ZYUl6uM
         PsSsrGFCoQhNzaDmuY1jNng159wlriwobznzKYSEKkiiHoi0NECvbwM68ODo3tPMF9De
         qVue+pN1m4sUvm3XEVOOKEzUxuCU6gEVvYAN8NWfABcQMPxEIsb/Hf42v8G5eHc0qw0V
         F2Wg==
X-Gm-Message-State: AOJu0Yypt/sJUFOvnfvRr248NNl3CvLql1jSqlWM0x92XDEAg5Biiftz
	VJ9XZ2ar5yw0iWCbLxpJNeaU9J9yP0lJQyaIDDD9cX96lkVQM8LUPcIkwWGGWO//
X-Gm-Gg: ATEYQzx4pLsTxSWnhch73JW2T6W3w2yTAVOS7gkVV85NCKgqquUCS8t8lSUu0HbVUde
	hXHjaGSykzx8YUtmfQEYhaDJBZe07gG1G9aoGoOo9iEkHyT2xloorT6Ac3JklBDsEwqFHAUoZIv
	BkXgNkmME347qftQcQqpghPRal8OpgMHWi8KsUPxHNxvANqy3K8BHo6qSr9c3rXWLkW2f7Y5Nne
	FasnR2GigixW4XwXigi5yKGJjGr5BCC87LKQS/byl5aK2GHzRQJRna8j0GhisYoQxULqeRzWhGA
	gbot038uCwNisRAvCZQ415MZl8v0oKC9SsznFX2l0nzohpLMFVQzIWWzcRRRfkFP/ELj0ugLr/5
	AJs6E/ZufxX29NPa5oJkNYVlWBg/Zyw7uMi/nLPLN3G4KZSTMoVqtXUpjA0bIYViMpmK42JadEW
	8Ly/k9NY6E4aNNarmv99KJt+4uJhbkYeC/KNUklNVJFWdKCvnjSuY40dF5uDZp
X-Received: by 2002:a17:902:ef4e:b0:2ae:575b:1b81 with SMTP id d9443c01a7336-2aeba45835cmr997025ad.8.1773245533663;
        Wed, 11 Mar 2026 09:12:13 -0700 (PDT)
Received: from eric-acer (36-225-72-126.dynamic-ip.hinet.net. [36.225.72.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae34de5asm30796535ad.55.2026.03.11.09.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 09:12:13 -0700 (PDT)
Date: Thu, 12 Mar 2026 00:12:10 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev, tj@kernel.org, void@manifault.com,
	changwoo@igalia.com, jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH] sched_ext: Add scx_bpf_task_add_dsq_vtime()
Message-ID: <abGUWjfN4QFsBg3E@eric-acer>
References: <20260311153957.699608-1-yphbchou0911@gmail.com>
 <abGRI8SRYT3BKILf@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abGRI8SRYT3BKILf@gpd4>

Hi Andrea,

On Wed, Mar 11, 2026 at 04:58:27PM +0100, Andrea Righi wrote:
> Hm, I'm not sure we need a dedicated kfunc for this. Sub-schedulers can
> read p->scx.slice and p->scx.dsq_vtime from any task, they just can't
> modify those values for the tasks they don't own.
> 
> So they could read the current value, apply the delta, and then use
> scx_bpf_task_set_*() to update it.
> 
> Am I missing something here?

Oh I see.

My original thought was just to make the API a bit more convenient.
Instead of writing:

    scx_bpf_task_set_dsq_vtime(p, p->scx.dsq_vtime + delta);

Developers could simply write:

    scx_bpf_task_add_dsq_vtime(p, delta);

But as you pointed out, the set() helper is already a straightforward
one-liner and functionally identical. The authority check is also
properly handled.

I am totally fine with dropping this patch.

-- 
Thanks,
Cheng-Yang
