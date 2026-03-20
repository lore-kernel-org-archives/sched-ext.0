Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CB43C3443
	for <sched-ext@lists.linux.dev>; Fri, 20 Mar 2026 16:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774025243; cv=none; b=mBJiuGRraqjA4NyoV3aPbasVf+mc2F4RsQcR6JWOsr7690d3+DIV2bDKicuFFhU+S5CuN/taDPNCB/8FgHMaKZEMZWIs5cRTw3lipdVI5eh9/kdngpUotmJOYtzoYUx/z7M4zjP2EIcLn/0x34XcaP9OtfEm0edMKR6zGG4lOMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774025243; c=relaxed/simple;
	bh=zW8GrpQDlgm5g2KgQWwbmI7hUPlq2kkNd1LKt0TyYlQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tqpVxvyrNbuGmQizzj3dZVf+V+v64taSkYLkvUPVOi5QX/4BHGMyB/jZWnxvEBRWR5FqpTERp1CAbJ8SCI69sG9DlInj8fqQKfz18xVagydCvWoQ/2PLLan/uTgcI5cg1+wD74APey5baHzL9zKkV+Oms9GvshTeZOzvFIJ69uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TZBG1Fif; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TZBG1Fif"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-486fa35b005so20788675e9.2
        for <sched-ext@lists.linux.dev>; Fri, 20 Mar 2026 09:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774025240; x=1774630040; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zW8GrpQDlgm5g2KgQWwbmI7hUPlq2kkNd1LKt0TyYlQ=;
        b=TZBG1FifXQLNUX9a7Z3D3TzTgf9k6lOlqR2C4FmgJjyVeIh9m6R0VJ1zSmI9pmdWrK
         8RtuvSto4LkIr60EatwMRI6e/NlRHrL1kjNnS+yIDyBE/kiQ+4/YeImERS0KBuo7NXDc
         BeMIdTSleri37HxwONhCJFmVRvIYh7Y3uRxud5edQDMHh6zUgp4fpx1rCWmFjqBrcKN0
         2Rg2RFAB/LC6eRxF5EzNjBB2kRcpI1GpbpRrT8IWzdRdFLbhCwnjovdxruc8O3y0Okd4
         Db2krF7nNBerll+lXpEWHUyyYmHkGsxrPSJeuKW78kAtkXJbB3KKJs/Gv060nYvSjrr4
         F7Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774025240; x=1774630040;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zW8GrpQDlgm5g2KgQWwbmI7hUPlq2kkNd1LKt0TyYlQ=;
        b=h0a38CMAmGQ8Cd5drXWb9hD23p4tSWsrtucjafLgCO389T+fAa4u3Ztu9oqYxjAzCA
         tpvlteubOPCtL1yv7AHIJnUltpzTa/EgMDGoOoLCdA6H4w8Hjow0dIlgevqPb74xYctq
         oGTCwa6YAOO49zNftcXLI1FRrZCTaifqjitA1WEkwGB3tfhSc+VOeu9awWxak4GQOCyK
         Ce5nmSNvGWQeBfhdsSBMvWFdnkq/nRM+rH7YTml7kEuVBY+570/Om5u2VglA/P8F0SAr
         WIgsPo5wchs+Ea2BFqOmG4XgyZLst+7+PPWEFafWFvG/ABBR+jhFiVZKiNOJSpwcbl1A
         ED5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVP1RbL4DRdyPRiSmgRxlWMrLCeZxIy5G38i1/HSMR1qyziLuiloJ7WOn74+MN1S3tXy6prFhLEPU4=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy0RPacUOeUXYd5ZfD22X5FieFze+6OC1R0UmWEYExhDP27YISc
	BT/Wte0iiR86EUzMELZEDwV6dMhDm3VZlDDq6X36iKm38voBFWucqj8hRwfVQzUA6wXer0wLb6S
	26rF7wm391s15Pw==
X-Received: from wmbjs7.prod.google.com ([2002:a05:600c:5647:b0:477:9c96:9fb9])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4707:b0:480:20f1:7aa6 with SMTP id 5b1f17b1804b1-486fee231cdmr52691015e9.21.1774025240258;
 Fri, 20 Mar 2026 09:47:20 -0700 (PDT)
Date: Fri, 20 Mar 2026 16:47:19 +0000
In-Reply-To: <DH7NTJ4IRIY1.GFW9V7S6Y1KU@google.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260305062900.43450-1-arighi@nvidia.com> <DH7NTJ4IRIY1.GFW9V7S6Y1KU@google.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
Message-ID: <DH7RGO3IWK1M.U5C5YN0W5EL@google.com>
Subject: Re: [PATCH v2] sched_ext: Document task ownership state machine
From: Kuba Piecuch <jpiecuch@google.com>
To: Kuba Piecuch <jpiecuch@google.com>, Andrea Righi <arighi@nvidia.com>, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>, Daniel Hodges <hodgesd@meta.com>, <sched-ext@lists.linux.dev>, 
	<linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri Mar 20, 2026 at 1:56 PM UTC, Kuba Piecuch wrote:
> This prompted me to have a look at the logic around SCX_OPSS_QUEUED and I can't
> convince myself that it's correct in the case of direct dispatches to
> non-builtin DSQs.
>
> The only place where ops_state is set to QUEUED is at the end of
> do_enqueue_task(). Notably, this assignment is skipped in the case of direct
> dispatch.
>
> direct_dispatch() will then call dispatch_enqueue() with SCX_ENQ_CLEAR_OPSS,
> causing ops_state to be reset to NONE. We end up in a state where the task
> is enqueued on a user DSQ, its ops_state is NONE and p->scx.flags has
> SCX_TASK_IN_CUSTODY, which doesn't look like a consistent state to me.
>
> Am I missing something here?

I just saw the comment in ops_dequeue() introduced by your ops.dequeue()
patchset, so I guess this is WAI. Please disregard this comment.

