Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E9B32E149
	for <sched-ext@lists.linux.dev>; Fri, 28 Nov 2025 13:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764336393; cv=none; b=fvBofWGFXBgBmPG1LkITW6IQnYkYLjQvUePtfa2rpQCClyUMb3HQFhspo+LHXzSNCMyJo5zPsEbHtZz7/5SMwXw2Oa7B+EgIG0iMQgpHVOjHz5vl1eIkAsJXH+ypevagsB/C7LtHy3Dig/SUgoWzfOt1tp2y+Ga94YPlel49GGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764336393; c=relaxed/simple;
	bh=8x47yzwj2tGCiRacw93B1o0QRGD7VwnRJxX4L8L8WhI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IZEbb+c82FtrsrAwqp3VEvl5RXuOZY6OZ4mCYMlzDvkDRuQWlhWWPOszdYcKmOojT2h3ftu29SZiSha7eDXHSD9BCAB2jJrxDs7vnASnCC+QVbrEftkop3bi6lEGksiz+9/x4ROfEGculumywQhVwrv+A8dMvpk87kv0DkrO/Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gDRtq33X; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gDRtq33X"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-477563a0c75so11292345e9.1
        for <sched-ext@lists.linux.dev>; Fri, 28 Nov 2025 05:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764336390; x=1764941190; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8x47yzwj2tGCiRacw93B1o0QRGD7VwnRJxX4L8L8WhI=;
        b=gDRtq33X0E9+dYFNLUza3r1arqp1jtoVB0jGQ605DIcaMnQ9baqIS5mPafnuOATiB+
         jd2IGiHR0RAhueH40LgRBf2W44QBr45iOV2MsLPD/b9F078lTmv0NXbHFoNdLxdi121z
         Pc/2dzeOAhSPBNR17h6AZvWMUGB2Km/plQZv8xXuduUaS55biszFgKAtQNilhQLw75Bq
         6tPkzSJRB42HNF6Jk2mmaP2LJ4xzll7jwxOtmfYOyFNqW7ll2iNWZqocSeCv/23hyri4
         ZqDJd7lWdXgBeOgg0FD1gtzFHbau+mdakCeqnSCJImOVgEwyV5l7vyA34dNkjPDtg1+k
         SqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764336390; x=1764941190;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8x47yzwj2tGCiRacw93B1o0QRGD7VwnRJxX4L8L8WhI=;
        b=DcI+nchTKR9rf/g2AlnG9af2TurmNf36peqV5Ew+GKnXnGmcYTRv7ujMAG4u5JAWcr
         BD9di3sTuJBxp85xvVknYS5q8r6gV89zYOC1AAq3BW6Ag62sYcvuGw3sbeRrBNbHIm3X
         cuKjSEl1AkqefltUngBaUNnPTF9uwZVZ3qhV34gQR8NCWnvxnb6h+1PCyAxuVxSdECpj
         I3auEuGnkJ8wv6KGk6mDZeMDCLz/Kew0Cfw2LYmHvMoQBu5P7WtdacZQybXB0wbRoJ1g
         1q+FuymrMTZX6eC8rL3Bo6AonJVwZwyGttRRxB9SHB5V+gVUvVpf/Bif4vzGYK4v1Ikd
         DgVw==
X-Forwarded-Encrypted: i=1; AJvYcCVflTRFskf+49F0IptTeFaaG5KM37FlYR3aEXSvC5hkjKZ5sl5hhuz7cK4D3Gi3esIUYUp8iNcRgok=@lists.linux.dev
X-Gm-Message-State: AOJu0YzUntQsxAkDM2RBH19YxJtEukQv2c5FHvChTvwXYwfHf+ZkkCBr
	nQiDDBNYRAY7rQO9Lvggd9S/p/iXScckBuBNTESJR5nOnIehJ7/rRu/e/Gm1qYbyQ4LGIygMlEq
	b75SeZMLk3nSsXw==
X-Google-Smtp-Source: AGHT+IFhzOANB3AIhWZg3Rl/NtAg6v4rb6rA3s8kQfo/HcHzmm7b3ueoYn3+ljIo7qCgAipySsLcZDGLdqh6mQ==
X-Received: from wmba19.prod.google.com ([2002:a05:600c:6dd3:b0:477:a0cb:7165])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:354e:b0:470:fe3c:a3b7 with SMTP id 5b1f17b1804b1-47904ac4380mr142615285e9.5.1764336390707;
 Fri, 28 Nov 2025 05:26:30 -0800 (PST)
Date: Fri, 28 Nov 2025 13:26:30 +0000
In-Reply-To: <20251127154725.901391274@infradead.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251127153943.696191429@infradead.org> <20251127154725.901391274@infradead.org>
X-Mailer: aerc 0.20.1
Message-ID: <DEKD1W6CI6UJ.3TWR30PXQCF8O@google.com>
Subject: Re: [PATCH 5/5] sched: Rework sched_class::wakeup_preempt() and rq_modified_*()
From: Kuba Piecuch <jpiecuch@google.com>
To: Peter Zijlstra <peterz@infradead.org>, <mingo@kernel.org>, <vincent.guittot@linaro.org>
Cc: <linux-kernel@vger.kernel.org>, <juri.lelli@redhat.com>, 
	<dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>, 
	<mgorman@suse.de>, <vschneid@redhat.com>, <tj@kernel.org>, 
	<void@manifault.com>, <arighi@nvidia.com>, <changwoo@igalia.com>, 
	<sched-ext@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

Hi Peter,

On Thu Nov 27, 2025 at 3:39 PM UTC, Peter Zijlstra wrote:
> Additionally have set_next_task() re-set the value to the current class.

I don't see this part reflected in the patch. Is something missing?

Best,
Kuba
