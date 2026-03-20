Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833913D8113
	for <sched-ext@lists.linux.dev>; Fri, 20 Mar 2026 18:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774030601; cv=none; b=Hysf9PMaUCFHzDVc0wTP/YHuEJZQzwJi3etyi7/Wd9waZdrbusqpApdMfllPi8LW5SGybesdWmBilQBXzytFd7MWWZ3Tu+iwwLVauB9PE1kjXspRG3/xa6Dmrw44jcnmR5AwJ6rpopizbOPYnLOTeuMTVOsL3XC9Qf+qGDygYSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774030601; c=relaxed/simple;
	bh=2eaBlWd5jGD3rJQwpesjYfrICE3jh1zZbHY+s3dEnpc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b1rXMCYQGu6+pSO84pNAel35Pc2zmnKBXeauLXEJwScxLIZF8QP9dkisILS7Ofoie5p+IEvT7YX1gbkfPyn6ZSjzDP5PHzq1AqquDjmYVE2e2tyRAdCBC3FG0aXUD7nQvz9HmCArxEYGbrinAARFPLFsn+iUeHoIHfnZwneAAds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c8d21yj8; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c8d21yj8"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-662fd150354so4582231a12.2
        for <sched-ext@lists.linux.dev>; Fri, 20 Mar 2026 11:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774030599; x=1774635399; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=175LY80cvo4magxg2e73J6AXfntCy1Gia8IrNOJcCIU=;
        b=c8d21yj8SqGS6rKca64XsZJqKBffq3WWKlf3lZxZvXYc8G2Fggo1bHEE9kaCgHucQ2
         q1w+aZ1Twg1VDvWwzQ/QUK4dHqc18mOzr2ceueL6IxGQqxlQYtfdfVsl1qa9fvqSvgby
         o78XCkf/2iNUujzwjKIk4P7eTXcDxLFivVsAxJyowsBxiDcZfFa0StNb5Z5gudEuCi79
         DJ0Q5boacO3XMqjpkbnwWDxu9JrdbKb19YYx7XBXko7sUmTgwkmVuSmCJZeTqzi+ABdz
         YLdoacyYCT2u+byO2THoBylDevuJGHKONaObjHvKPB3YwTf5J3Daqp5gFBFK6Ntw3Tt5
         Laow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774030599; x=1774635399;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=175LY80cvo4magxg2e73J6AXfntCy1Gia8IrNOJcCIU=;
        b=BN+GNkIMVcitKbiuK8YWsMf2W0EBuoi2Ajh37yQ9odfum6G5W7s1kuDFn7qR90o4Yx
         P22owmqOaBUAigB1iHL25FCVZF2pdLW67nHrZmkwlUoWPPabws2lKph8oJUV+LdHDm+3
         TCJ8ztu4R83G1t3WKiuxTK+GNw51dN4irbN4dCwM/0LuLjKog+R7mPNrabeFvVPfSwZp
         7wmi2zelNT68EWUCb4HVOUITAH0vtOA/IzUCvX6L48xIhxrOX87Xwq0IE3Y4a0O86j3X
         tdBaWXU+rEorhaiCuGGXZ+xPg66NNsRrx2/x/bc6ULVjtPbSl8DWLhEZuaxQRjbC+Sbr
         nncA==
X-Forwarded-Encrypted: i=1; AJvYcCVbP5Co/mkNHpg6WwA3BtllTlQzwr3FrrGr9A00g2I66DRZzS3lYylw0rt6o4Iv50nbE89LiCl6x0U=@lists.linux.dev
X-Gm-Message-State: AOJu0YyuizpbMq+p1uCMxResWUXqvqFtl59s2eojS9JuLY8jdXRIQyfM
	gZVg28BuV783RFi/0zcYXWfpAqu03ypYsEEq7TElbb/39e+ZMiud9augidTNxWCZkndmswHqshl
	yQjYMpnATAiQnBw==
X-Received: from edsc4.prod.google.com ([2002:aa7:c744:0:b0:667:4c3d:fc68])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:1ed0:b0:663:f97e:5207 with SMTP id 4fb4d7f45d1cf-668c84f23bcmr3582223a12.0.1774030598677;
 Fri, 20 Mar 2026 11:16:38 -0700 (PDT)
Date: Fri, 20 Mar 2026 18:16:38 +0000
In-Reply-To: <DH7NTJ4IRIY1.GFW9V7S6Y1KU@google.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260305062900.43450-1-arighi@nvidia.com> <DH7NTJ4IRIY1.GFW9V7S6Y1KU@google.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
Message-ID: <DH7TD1UMMNIW.3FYBGIXBZ7E3O@google.com>
Subject: Re: [PATCH v2] sched_ext: Document task ownership state machine
From: Kuba Piecuch <jpiecuch@google.com>
To: Kuba Piecuch <jpiecuch@google.com>, Andrea Righi <arighi@nvidia.com>, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>, Daniel Hodges <hodgesd@meta.com>, <sched-ext@lists.linux.dev>, 
	<linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri Mar 20, 2026 at 1:56 PM UTC, Kuba Piecuch wrote:
> On Thu Mar 5, 2026 at 6:29 AM UTC, Andrea Righi wrote:
>> + * - %SCX_OPSS_QUEUED:
>> + *     Task is owned by the BPF scheduler. It's on a DSQ (dispatch queue)
>> + *     and the BPF scheduler is responsible for dispatching it. A QSEQ
>
> The task doesn't have to be on a DSQ, it can be queued on some BPF data
> structure instead. Even if it is on a DSQ, its state depends on whether it's
> on a user DSQ (QUEUED) or a built-in DSQ, e.g. local (NONE).

My comment here is incorrect in that a task being on a user DSQ doesn't imply
it's in QUEUED state.
Now I actually think it's impossible for a task on _any_ DSQ to be in QUEUED
state, here's why:

In order to initially get on a DSQ a task must be inserted into one via
scx_bpf_dsq_insert(). That can happen in ops.{select_cpu,enqueue}()
(direct dispatch) or in ops.dispatch() ("normal" dispatch).

In the direct dispatch case, the task either:
* stays in NONE the whole time (ops.select_cpu()), or
* goes from QUEUEING to NONE and stays there (ops.enqueue()).

In the normal dispatch case, the task must be in QUEUED state for
finish_dispatch() to proceed, meaning it can't have been direct dispatched
earlier. Then, the task state goes through QUEUED -> DISPATCHING -> NONE
and stays there.

scx_bpf_dsq_insert() isn't the only way for a task to be inserted into a DSQ.
There's also scx_bpf_dsq_move(), but the task being moved must already be on
a DSQ, so it must be in state NONE, and scx_bpf_dsq_move() doesn't affect that
state.
There are also other mechanisms like SCX automatically inserting a task with
slice left into the local DSQ on preemption, but these also preserve the NONE
state.

So, QUEUED means the task is enqueued purely on the BPF side and isn't present
on any DSQ, either user-created or built-in.

