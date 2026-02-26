Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF7039A7ED
	for <sched-ext@lists.linux.dev>; Thu, 26 Feb 2026 16:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772123171; cv=none; b=sD7ykyJEFp3orJWN8ntJ+1HCHMQrYfNeiIdv/soROud4dH2oxalhxiBHYUnmbRvQYKiBdqEva4og8uOMz3GS7F+mjSqSQFbAEXd9jco0OsYTsKVFwq3vycSsQVv0Igs58U/1RJaG7blBCJDc7UViEJbJPvdrmgfw2Ulv6JJzIqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772123171; c=relaxed/simple;
	bh=iMz3JjCEEDgr+u+ZxWBQIDxqJrYAmRmu6TUKDJU0hKw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=YNRubB2yuZTRhqUbTQd2dQo/1L+wHQVQOoE9aqcTVXta7U5tBdhKdFqQHB9x939KFDSh4L7iy/yHbXs6qnh5hpqnewy/loMZNY7WcQxPw7EJM6Y1shh7TUO42jslUW6WMJUKQpdG1XX3Sg7vFD1Xb3SwrWi1UA1CD1qO0mNAR4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SztFwV5/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SztFwV5/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772123169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iMz3JjCEEDgr+u+ZxWBQIDxqJrYAmRmu6TUKDJU0hKw=;
	b=SztFwV5/spCy3kCREEOnQBE8OlayLDJPIViFNlLfksLCdqbGB2yBqXC+/31xIUvyPJb0Tf
	QXdHyTgY6jRXYa/1kocUl7js62ZjmncN+YTePPJlQMXgS8BVFqPXUfRcQqaJ0p6opcGYVW
	uHqS+/bAtJzjGzLmjzFloZsWk6FebsY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-JFPt-XeRNuSGfPDKuMxOTg-1; Thu, 26 Feb 2026 11:26:04 -0500
X-MC-Unique: JFPt-XeRNuSGfPDKuMxOTg-1
X-Mimecast-MFC-AGG-ID: JFPt-XeRNuSGfPDKuMxOTg_1772123163
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4836ff58111so12183935e9.1
        for <sched-ext@lists.linux.dev>; Thu, 26 Feb 2026 08:26:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772123163; x=1772727963;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iMz3JjCEEDgr+u+ZxWBQIDxqJrYAmRmu6TUKDJU0hKw=;
        b=CKx6T7z8ln2ysEUmdZFNRRYHT+HxJyOzG9QFvq/4P7+qTGe9BoaPDiv0etSCEx8B65
         QmnwKQvC3Jx/Ll/flREuLXRTspK0PGps8CaiWLpAPfJJeiBfAczxUtAGrKUfACcsJB+j
         HvCO+uE9ox9I0I9NQdGNAGt/Grkih2BxmLCqcDB4e58+MxZJ4aqT9zYlvFT9uSjcIsN1
         XdXigwIOFrqifmR35tfs4gYh3JUnAhesDjoEWP0u9lnr51Wuw/kSYI47g7OjeNzl05Ds
         hFnaWTR+KXy02tekRX/PH/6Ygjo+txC6jDoU/P83advcIwm6TXVYbludBSimz/XhiYnb
         0VcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyetEZ+BzJ/E/Qbo9vkxMbcVEXq2BXs92q2oZNkK2GrjGVBlqgBPnBFhtbkovz9LMTQfvAhbOMOO4=@lists.linux.dev
X-Gm-Message-State: AOJu0YycBh4lXGsH4l6I+Gbbvq5XQSPVPMK++Pbdq/g4rDlODj028Lld
	uZr5/pOmsACzTQjm/xlT/jnUY2DH3gBxM77y3E+reJYUOW8PippdHIVYbnPxCD/y9e5sASI98UQ
	GUT06p7gO8vHQifaJIVuPO9MdtitzjRkMfBHYpld1ixx/Cfvnmwy7vO7YXMaj3A==
X-Gm-Gg: ATEYQzxQMKK3IRmDyZ0veT83hjVCQd7DChTJv7TDeB2ILYKysTvVm0luEl9joZEfTDK
	M+sgZKRazEJZmQltNjm4NuUTYz73y3/cjmDb8/Afg0deXNdDQBFf9s/R81D7UHv0yD7O+xpUS0K
	yHnhd+lMq4qNswBOIeQf4G8UaqRbWGO5Ga3l9ThHug6XZuiklasV4dS2tOpu0Cn22SW8MkyaLso
	FtN5q/tLaQVTyXE70D892UmP74SCsk0RKcVGUenXSLIPdSuCCghmbFSaQxerUuuU7JjUUg30Izr
	83RK9M10vRFDSjH7PgGXnx10CHxya7JhAPD8Q7w/ZzC/7dX8nkKP9HeHuiH1iktZrL6kQasW9Tg
	DsoYKYj/iTcMICLdYkw==
X-Received: by 2002:a05:600c:4f11:b0:483:7903:c3b1 with SMTP id 5b1f17b1804b1-483c3de3911mr35388955e9.20.1772123163002;
        Thu, 26 Feb 2026 08:26:03 -0800 (PST)
X-Received: by 2002:a05:600c:4f11:b0:483:7903:c3b1 with SMTP id 5b1f17b1804b1-483c3de3911mr35388675e9.20.1772123162585;
        Thu, 26 Feb 2026 08:26:02 -0800 (PST)
Received: from [127.0.0.1] ([195.174.33.230])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c3b3d24dsm44190465e9.5.2026.02.26.08.26.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 08:26:02 -0800 (PST)
Date: Thu, 26 Feb 2026 16:25:59 +0000
From: Gabriele Monaco <gmonaco@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andrea Righi <arighi@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>,
	Juri Lelli <jlelli@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, sched-ext@lists.linux.dev,
	Tomas Glozar <tglozar@redhat.com>,
	Clark Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org
Message-ID: <deb203ab-7564-4bef-b4bf-053c6ec08f27@redhat.com>
In-Reply-To: <aaBrMr5O4455oU31@slm.duckdns.org>
References: <20260225095122.80683-1-gmonaco@redhat.com> <20260225095122.80683-15-gmonaco@redhat.com> <aZ8snSHWw-U0lVz2@slm.duckdns.org> <8fbc3ced19fb0c2a2171708073fa51ae308755b5.camel@redhat.com> <aaBlJT9Mac9KQpKL@slm.duckdns.org> <f49a6db6f0070350cb2d2b023b5733a3646996f2.camel@redhat.com> <aaBrMr5O4455oU31@slm.duckdns.org>
Subject: Re: [PATCH v6 14/16] sched_ext: Export task_is_scx_enabled() for
 verification
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Correlation-ID: <deb203ab-7564-4bef-b4bf-053c6ec08f27@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tA_b8gA2Lu_G40zh_si2fW5UUpmWH0R6nptkKwbvS2g_1772123163
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-02-26T15:48:11Z Tejun Heo <tj@kernel.org>:

> On Thu, Feb 26, 2026 at 04:42:34PM +0100, Gabriele Monaco wrote:
>> scx_enabled() might as well be exported (together with its static key), but I'm
>> not sure exporting the sched_class is the right thing, since all those scheduler
>> things are quite private.
>
> Don't you just need the sched_class pointer? Can't you get that from
> kallsyms?

Yes that pointer would do. Do you mean getting it in a task_on_scx() reimplementation I would just use in RV?
I could do that but I was looking for a more standard solution.
While very likely the pointer to the class and the class field are here to stay, having a function like task_on_scx() directly available in include/linux/sched/ext.h is less error prone and future observability tools might need it too.

But let's rewind it a bit, if it is a big issue not to have it inlined (which probably isn't), we could just go on with something like _task_on_scx() (inlined, for the scheduler code) and task_on_scx() for other users. Wouldn't that be acceptable?

Thanks,
Gabriele

