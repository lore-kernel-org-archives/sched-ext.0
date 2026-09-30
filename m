Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D194C9E09
	for <sched-ext@lists.linux.dev>; Wed, 30 Sep 2026 11:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790769079; cv=none; b=D1kJ1g4zFX7VZ76jVbR5mgbclaR47Syd/FUC2ISdSdNLbYeydVDwi0CROx7gvsSwZ1D6xIJFJBjN7Fv05EjOexidz5RGYqlYwr4dWkfVdicNm7jhCdCks6Q6ZU/N11i1adZyk2dtd2NFsKP5NrjVZobydQ7fKBo71vFXWQPcO6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790769079; c=relaxed/simple;
	bh=gXRJKrPhjzj8gZ1pv3u7OB2hruuDfHXgAkamLmyAIqc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OAewQqtIf+jJVGtjL72DZ7Ox0HewPLcUErpihAlWDedwRw7hCKislpCFonueMJQHbmorhd0jAOP13Y6kPY8+zSlxbqc+NgbtijNkwFxgEHqfOFBMVrPOJOzwxRmr60DEOxH/28hj3a6W6vpafmnux6VFo9tiRtZ8YPY5VnIOFmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sJLCdR5A; arc=none smtp.client-ip=209.85.128.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sJLCdR5A"
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4994d67d0e3so37777785e9.2
        for <sched-ext@lists.linux.dev>; Wed, 30 Sep 2026 04:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790769076; x=1791373876; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sPYuwE1/0bF4HTDsvndpoot1c/MYhCPRtMeze3nyqSE=;
        b=sJLCdR5A9HwYuZLB7vQIv5qN0h1oOI0bAFKfwdegg4ROKU1XXPzWcVsoy/pgIEgMX+
         2eQwSGvb4QGDLyqRpEuJThAEWrU3Lq3ZQPfLxSp+svvK6NIOJfvgYUpEdoH7hwLtY4TW
         KVWYhfRfMp/T0o5EOa0LSwLt8YZmOIfETcMOWQZHFF0fG+ytnZdvEwp7oV5Po3BhzaUq
         gqYe86A29ID0t3G1iq+KPnz6WTd/+VZ+dI349okSLqjfQv1Q+rFEQLFLMpdo/8abivaR
         sNATgfRLrk23WZDQPcVV0M04BV6TMIZCFMddbNcEGx4HU66RNzEn0hMHY/5gTGrvCjnn
         zr1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790769076; x=1791373876;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sPYuwE1/0bF4HTDsvndpoot1c/MYhCPRtMeze3nyqSE=;
        b=kesbpOo49mt8t5pupDHARiUdptneH9pnXDqMKKyOVCmqU2rOuV96+gXLhcxXuOur5I
         ypx5up/32Tzn6yuhzU+PWnVcpO8CCtSBGZrgAAwWKb4PDQgWXFtXfFJh73ZfP3R/AeBR
         ranlf/55dFjzIlpdnHPgJX4APWugVpHo2xa+tbg4uyu3HL1olX4jpBbUJVGRiV5jbJQ5
         zP9jtp3qrsd5AmFqlatOlRCEQuMDizXbB8GAKMf7O65gzI1ds1OaXsdGyGv3VmJfqDYw
         KCzx6F9ii0Lt9a8B4wNovDyyQZQMAmMi4y7x5fNWscPDreHjLALoIbrTke3gJnbVWDdY
         yGuQ==
X-Forwarded-Encrypted: i=1; AKwUvBxydU9bloaeuzZGykmGEbdCTOrPfdYhTT2gbLOKw9SS2awPK5/pkT9zwXeAqiCBrBgfKTv3GOezxoQ=@lists.linux.dev
X-Gm-Message-State: AFuF++n26HAPtS6PXyWklmgvvgg5LBh7AJG5SvqDrrgOlZ8FTS00c0J9
	+S5YBhAnGO51Lk2BA3c3GjOOrDAIg0fY5BpeQIY55HiC/mp8eenrqTOttggRJ3ZWNYp5oN/Xgzg
	xNw6gjSy1LzxGHg==
X-Received: from wmoj20.prod.google.com ([2002:a05:600c:4854:b0:49f:e58b:90d5])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1d0d:b0:49d:17d4:d6ad with SMTP id 5b1f17b1804b1-4a01b112cbemr18408285e9.23.1790769075880;
 Wed, 30 Sep 2026 04:51:15 -0700 (PDT)
Date: Wed, 30 Sep 2026 11:50:40 +0000
In-Reply-To: <arwEiZVRNlrOosFi@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260929161730.185271-1-jpiecuch@google.com> <20260929161730.185271-3-jpiecuch@google.com>
 <arwEiZVRNlrOosFi@gpd4>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930115044.337291-2-jpiecuch@google.com>
Subject: Re: [PATCH 2/3] sched_ext: Call ops.dequeue() when a task arrives on
 a remote local DSQ
From: Kuba Piecuch <jpiecuch@google.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Andrea,

On Tue, Sep 29, 2026 at 08:33:45PM +0200, Andrea Righi wrote:
> Nit: nothing between the top of enqueue_task_scx() and scx_do_enqueue_task()
> looks at p->scx.sticky_cpu, so p->scx.sticky_cpu = -1 could go right after
> reading it into the local variable, as it was before b75aaea24c9f. Same
> behavior, but it also covers the SCX_TASK_QUEUED early exit, which currently
> leaves p->scx.sticky_cpu set and essentially makes the fix a revert of the
> enqueue side of b75aaea24c9f.

Makes sense, done in v2. The clear is right after the local copy is taken,
guarded by "if (sticky_cpu >= 0)" as before b75aaea24c9f.

> Either way:
> 
> Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks! I kept your tag in v2. The only other changes to this patch are
the comment and description rewording that Tejun asked for, plus the
7.1.y prerequisite note.

Thanks,
Kuba
