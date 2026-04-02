Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8C43264D6
	for <sched-ext@lists.linux.dev>; Thu,  2 Apr 2026 14:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775139206; cv=none; b=O0Rv7fEEFx0au5eZm6qTOQrL5ESLv0RQR7nA8PYq5sUFkgdzZr23ea+cpkgCIh/2HA3ii1vBohXymGVddT7nLAzc3WLL+YXf6/E4GB7TSozMTqkD/ih/OPPjMaq0lVfjzyJKZ7QVe692a+yI9clT+lWzGoMOctejleWB/4krt6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775139206; c=relaxed/simple;
	bh=SuRN7qly4s3ceLzd5tJA5RAgim6jIz/S496DedkAKRA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rhbXmpoaOwD+2xdrEw82wQ2qFnLJGb/amoBCOo5gjcNyFYGN07A17PwlCD47YepDhe4rljjn7U+raOvC8I8QnoAKbK9LOzIOUI174Ob/Ti0JdDgn4S37R9p2+tOeq8piV2wX8PNyRDDGZyD/DLhCj2Qj7o89Pl6fMQ5Go7LoAHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GWz2wr4r; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GWz2wr4r"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4853b5b0fafso11076905e9.3
        for <sched-ext@lists.linux.dev>; Thu, 02 Apr 2026 07:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775139204; x=1775744004; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hR7KwIEWfhUL9vCYoy3LE/AFP3V7kb39QeSgR/ASWis=;
        b=GWz2wr4rDqK8JD6Fol1z/UEdzVlFgtCZJ8dj1b/i08hmU8VmpL3juukL+NphwLqhMe
         baXlv69+OGL62G7aWkYzt4bM9K6hJ1gKcwjq3ltoeE9W6ppMNsZONlAfHnbnKkpYKhxp
         UWoqgs13JUbaMn1p0o/XtbkCVx2+RnyULeynNZTohUO1nNBSrBPimgyMkaIU2g024wAZ
         DEq086EpAFqovPIE/G8G56TBwIgL2biBlwd3OmK+KENjyGfXitnejFrNQC3gzirreuWE
         i0suIY6I1ornn5c+NmCeEuOlohRN7o5lSuV0aI6SRx9vYS9kTYM79m1jLcmMBwaKiMIq
         ufYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775139204; x=1775744004;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hR7KwIEWfhUL9vCYoy3LE/AFP3V7kb39QeSgR/ASWis=;
        b=YnfdYBeX0Clw7uXr0hSw7eiPmgzSuB7jd4wKrCLeWGNRsO0C9tfOJK6FijCbd7Fhnk
         ABTFWgTqXCb8HNoqiko84IWQfvQLFAe/tsq/RJxO4zcgFmqtUiRUKPiUopyvSOELy/cQ
         6aG5wBQH4xYvaQ1z/igEkKHek/u/9SAonAEIIVgdq487hDS0PPmL4oKO/VpCXF0yD+GO
         4wJeUFTPO1VfyJkKeTEBw889Dl1btKx0KuvdZMYqntR96EwFFki9OMBeSv4NUT6xULOV
         lfv46E3x3Xk07d3qxbTTnaBHIguLl3x4VCsv+sXJgFwIFNc9QEpF55qgxJwined0bywG
         bLbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwl++EW8UfMSqZZ2BPD5sMaHOSh+1P41nIfZ4p/baAYGbW+QCp0i08u5DKaVrODcFg6sBJfY3pjiQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YxbY9GMEvE14ZdvBztN1bTrCkDaGKxrIjfuQ08zuRXIiYXVPPLj
	MQXIPh7pHpfIYvOHR8kL3aGktqi77upupXr2MjZ78NyvL7oFKftjFXBcct3/iSKCL+g9dihDX1M
	23HfifNzCHNTQeg==
X-Received: from wmrk22.prod.google.com ([2002:a05:600c:b56:b0:485:3ddc:f27a])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a10f:b0:488:81b1:ae36 with SMTP id 5b1f17b1804b1-4888b78657bmr40367425e9.23.1775139203662;
 Thu, 02 Apr 2026 07:13:23 -0700 (PDT)
Date: Thu, 02 Apr 2026 14:13:22 +0000
In-Reply-To: <20260402023150.660967-1-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260402023150.660967-1-changwoo@igalia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
Message-ID: <DHIQBVSN95OQ.1UEKM573UIQFF@google.com>
Subject: Re: [PATCH] sched_ext: Fix is_bpf_migration_disabled() false negative
 on non-PREEMPT_RCU
From: Kuba Piecuch <jpiecuch@google.com>
To: Changwoo Min <changwoo@igalia.com>, <tj@kernel.org>, <void@manifault.com>, 
	<arighi@nvidia.com>
Cc: <kernel-dev@igalia.com>, <sched-ext@lists.linux.dev>, 
	<linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Changwoo,

On Thu Apr 2, 2026 at 2:31 AM UTC, Changwoo Min wrote:
...
>  static bool is_bpf_migration_disabled(const struct task_struct *p)
>  {
> -	if (p->migration_disabled == 1)
> -		return p != current;
> -	else
> -		return p->migration_disabled;
> +	if (p->migration_disabled == 1) {
> +		if (IS_ENABLED(CONFIG_PREEMPT_RCU))
> +			return p != current;
> +		return true;
> +	}
> +	return p->migration_disabled;
>  }

The fix looks correct, but the logic looks somewhat convoluted. How about
something like this:

 static bool is_bpf_migration_disabled(const struct task_struct *p)
 {
-       if (p->migration_disabled == 1)
-               return p != current;
-       else
-               return p->migration_disabled;
+       if (IS_ENABLED(CONFIG_PREEMPT_RCU) &&
+           p == current &&
+           !WARN_ON_ONCE(!p->migration_disabled)) {
+               return p->migration_disabled - 1;
+	}
+       return p->migration_disabled;
 }

My thinking here is: if CONFIG_PREEMPT_RCU is enabled and we're current,
subtract 1 from p->migration_disabled to account for the BPF prologue.
Otherwise just return p->migration_disabled. I've also thrown in a WARN_ON_ONCE
to help catch potential bugs if the assumption about the BPF prologue ever
changes.

Thanks,
Kuba
