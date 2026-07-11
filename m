Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D4B3033DA
	for <sched-ext@lists.linux.dev>; Sat, 11 Jul 2026 05:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783749271; cv=none; b=PIdIoGxASNISX6W+FuToTAODXJ1Z7h1oucu+yseMwTdtWO10U12wbZHUu5YRMnm5wJfldcSxXG8pGooZCvZbtgCCQJkThkkfe7rBnzpRkaV07aiu4BCgZxhHGSjYdVINsG7Zwp1aExtjPzSld0v7W9kWu1BIXa6RhVUDcph3wv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783749271; c=relaxed/simple;
	bh=s8jLFIScodMQ29MEof5LclbjYvJlO2j6tbNbsN+hPN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FdoQAaEWsZ8oDVnEzeOzsHexrfmUAbvNlNT0OaGlqgfmL/seTyh/aBZAC9kGVIQY+Di3gCpjPNbyI+HokjHsACV0T9YMF5C+ZS2FwcYgVbusuduAZbFsSxr6ZViRhPaOmIVZC5OqoQq+GJAo1DqdivpHRPk+mXBjs7/2FTWH9Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b=iRZbYILE; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b="iRZbYILE"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47d70879764so1003798f8f.2
        for <sched-ext@lists.linux.dev>; Fri, 10 Jul 2026 22:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20251104.gappssmtp.com; s=20251104; t=1783749268; x=1784354068; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=s8jLFIScodMQ29MEof5LclbjYvJlO2j6tbNbsN+hPN8=;
        b=iRZbYILEuXg7p0oieIPYGbngkXpakeVKmxV/HMVVLSw0R6SwICByATy3lepL6iIoo7
         g0zipn8tJc47NkSZ1UyfwIasL76o8//mS0e76OHZYS02h/KTu4KUf5GPOHJR2IvRD2Wq
         xwAZaAPy7gbWgcaCoP3NRaJlJTimsCokVCGRQ1HHnY9/Z1I4ezcdx7Zij4WAikVgeNOD
         TFAdjUId6xO3KHIFWr2h2fRuYSvAKBRSSCsKrFMvia+dn3B2uKXrBBhzZ1cgxK/t/hvE
         ylaaG3vD9l9vqvZYbYTbfq+KltgZW1aDsZ1zxVaGv74V6uaU40nT7yQI2DzflgQ0gfeC
         wBvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783749268; x=1784354068;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s8jLFIScodMQ29MEof5LclbjYvJlO2j6tbNbsN+hPN8=;
        b=E1NrFMuZWyJU+P/XhiBprMqJqnQSIqpXYRhZewqda4eKkIYeclbGWnvXWQXg9TtP7/
         CMBgz+WdNEdr5x6vem7l2lRpJwrY6wCqtkNmetK7H5DjBIGH+QHdXK6X+CZKtfGES399
         4w88prrPdreL8H5BP0ssqomokIbZypd9b1eGdvwWhEboA+m3YeMiHdTinpJ8qych3ueL
         ct9PCoruk0OpwUlJitsLydoSQLLu5Wo/wHdU4VCpMwMqZv9esNg8lJIlQ06tnvQ27vuc
         RqssnetC0lW9WozKpQyQt/Fqy9dlGnCMu6LD1/0pVt3LX1RcQd3Mbm4qX1xIMu57kiTw
         W9OA==
X-Forwarded-Encrypted: i=1; AHgh+RoEOU8qXxhOzJBVwcxLOPc8/4YopTY5qvmVfMtD/lrnmBvWzUL1O9BQlrklXBDm59K5zuicSIutwrU=@lists.linux.dev
X-Gm-Message-State: AOJu0YzJLGTibu9JrN7QgAv72923bt3F4LZjAooR7FKmYHAlYgHU2YOI
	c78ZkzLFiFHo18eESxr9O9vEkNNP9hlMjtL9mQZpXaEr+ocNnUGHovgL7s5uCwznRr0=
X-Gm-Gg: AfdE7cnna55TgaSQWZ1r4aeNU89GQqUGyDLlRzdJ3IlqjSQznQX4ScyMMnRrhF2Lnsw
	wNNeQ5AaSSckPCzdZdgCINDBJxQCsSY5mdismkTvlvXpT6vC0jBJKHe4ye2w1zrCCKoyiKroOf8
	OrrNf3qNW2oByD4YmrOjGb179qHz+Gqpcrd16mQ7h4kwk4Q3pkbV2Vklle71gI7fgsSLnvkRTtY
	AlFUyYwT7n8ukhSzhciVkRO1jGi1C0VcqIi3sbrhjKEmDOQnaRT2qryqO+nEw8IEDN05XJgz/AZ
	rU76YuT5gvWmS6dST+I/G3WGp1ZKoPgjW/biwK76lVu3W1F3awgnmyflaXiWorsS8+HwBR0zDWI
	eYPQoMVdqtZoiHVE96p5/tC1rB/AgkcR9qSRjOjx8PGr5Do0JjhW982ssq2gwg8QtS8km6ml/cc
	8=
X-Received: by 2002:a5d:5f42:0:b0:475:5454:49f2 with SMTP id ffacd0b85a97d-47f2dcbffd3mr1436432f8f.24.1783749267440;
        Fri, 10 Jul 2026 22:54:27 -0700 (PDT)
Received: from localhost ([2a09:bac6:37a8:26dc::3df:54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0f21328sm67191335f8f.32.2026.07.10.22.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 22:54:25 -0700 (PDT)
Date: Sat, 11 Jul 2026 06:54:25 +0100
From: Matt Fleming <matt@readmodwrite.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Suren Baghdasaryan <surenb@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Edward Adam Davis <eadavis@qq.com>, Chen Ridong <chenridong@huaweicloud.com>, 
	Matt Fleming <mfleming@cloudflare.com>, sched-ext@lists.linux.dev, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH cgroup/for-7.2-fixes] cgroup: Create the psimon kthread
 outside of cgroup_mutex
Message-ID: <alHaU4MhWzq9kA1i@matt-Precision-5490>
References: <20260710100441.2653477-1-matt@readmodwrite.com>
 <20260710134945-psimon-fix-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710134945-psimon-fix-tj@kernel.org>

On Fri, Jul 10, 2026 at 01:49:45PM -1000, Tejun Heo wrote:
> Matt, your reordering trades one deadlock for another: CLONE_INTO_CGROUP
> forks grab cgroup_mutex inside the scx_fork_rwsem read section, so an
> enable racing such a clone deadlocks the other way around. The fork has to
> move out of the locked sections instead. Can you verify this fixes the
> deadlock in your setup?

Thanks for fixing this. I'll test this out ASAP and report back.
