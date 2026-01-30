Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AF436EA84
	for <sched-ext@lists.linux.dev>; Fri, 30 Jan 2026 11:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769774044; cv=none; b=go8khBDmc7y3rw1KiAQNycayWqbkutMvjqx6L8wrQL10RmovVwsLzPAxA0a1odgz7k7rFLfQyYXAMLLVO0RpHDWf8oX9LkF0gdUCUwmwsFGDReZMgfAiXRVGPkjDrLGXOJwbZmyknDgYf2xDRHRsvsfKHEoWfcn5/ZYcciFvwgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769774044; c=relaxed/simple;
	bh=TK+mA/mAevtJOngvguRrsd6I7cJZvzDA2qawlfZBSDg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A25M+jQyQpQGGq/3gRautlUmmSqosLVUigClkLFxjhvPYJmkIywPrzhk5wa59BIMa5DvANpgsjGq8mVbF4k9keyQGLinK/u+JFizR7I8AP8FxfbpIw3hQDKghCXayWjF9aR2US/YmMXB5iXg8pJvreKHXwWz9VHUys0WMVNZJ3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eWjDdKOo; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eWjDdKOo"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4803b4e3b9eso14864015e9.3
        for <sched-ext@lists.linux.dev>; Fri, 30 Jan 2026 03:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769774041; x=1770378841; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yWLfQaMCxd/sRhYR0V/QyqItxfbBpgyNHdrxmNX7bC8=;
        b=eWjDdKOo374PIKj0A8YlKL0ZAOn8oPxIvheRHDdmi7K7OAvvxW1+HbnWvvG9vpD90A
         7AunnFFXaJgy2edAOoxZ1G/ajj36nOqQqEV8Qt1+MoTuNoz/mm60B/vatMW+DXrlDoOl
         UXkSy/jrDk/foyY05CjMRw9F56BmRHfvgGOKlNPKZfBDk9Bu1c0LPvxVacMFZ3AKXPmX
         aWtacP0kKXXTkVjbtNFZdD/SkWcknYj2AUOT7sO+sbEOslod8fFaqNRvT7+9Y+ExbdMz
         Q0L+Upqdj5o9jBrLCtaw5ySN5CbgOKLuLr+2Rvu5EzgYlZ1NHj/Z/hQZKh5g2ljjdAM4
         gZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769774041; x=1770378841;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yWLfQaMCxd/sRhYR0V/QyqItxfbBpgyNHdrxmNX7bC8=;
        b=QKR66FzP+TLnflZZNWdfSQnaUNQiNaYfRl5Wk/I0I3yMhBQoFXzzCwv1gngUkdpE2z
         ZDaChniVzuSgNVwZFpQJ718i8v+1N6qM+2TpgW6ZMs2+vqD7tvjldkLSQWlmEabSX3BR
         dugAO6yG2es5I+14OtkDkjukc6O05mxo67Z3BcFOsC/OO2CwbnSShNnr2ZDU1OABDP1q
         9dR2HQFZtZYRHJHybCVYoB1zCJcfEti4gDEz2v3JiqCZtU25VI/cQ/NKiUfXB5Y++/cG
         TXnwQP8LVG1TlDT/X4WK6LKI4NhcJe65ogLwZfCLeYBVTkkO01jYCO95mSH0Xr/jxYzj
         T+fw==
X-Forwarded-Encrypted: i=1; AJvYcCX7nd1kTGHoijBGQLCa1AJMm3jXQL/ePIKaBI0WGQ0+fGotpezkraqWI0MLWkfrhZUREpDm7oY9Pp4=@lists.linux.dev
X-Gm-Message-State: AOJu0YyUBQGZDlqDltyABXng80DRI8UZ14qbZ5ZfngL/y5VOdNNVESh6
	Ka5kZwXRe/W/PBgQVuAaBjg3pNFi+2GpKRs8miQTZIdPzFq15Fr5HHbhSCgvyhnHjFyMddoGD3E
	UgLG/c2SB5QUk0w==
X-Received: from wmfv6.prod.google.com ([2002:a05:600c:15c6:b0:480:6c48:f9ad])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:310f:b0:477:7ae0:cd6e with SMTP id 5b1f17b1804b1-482db493e6bmr29179215e9.5.1769774041293;
 Fri, 30 Jan 2026 03:54:01 -0800 (PST)
Date: Fri, 30 Jan 2026 11:54:00 +0000
In-Reply-To: <aXp9xSpYhaysBLQ2@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260126084258.3798129-1-arighi@nvidia.com> <20260126084258.3798129-2-arighi@nvidia.com>
 <aXp9xSpYhaysBLQ2@slm.duckdns.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
Message-ID: <DG1WJEB6B0AC.151EBIUYXCR55@google.com>
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>, Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, 
	Kuba Piecuch <jpiecuch@google.com>, Christian Loehle <christian.loehle@arm.com>, 
	Daniel Hodges <hodgesd@meta.com>, <sched-ext@lists.linux.dev>, 
	<linux-kernel@vger.kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"

Hi Tejun,

On Wed Jan 28, 2026 at 9:21 PM UTC, Tejun Heo wrote:
...
> 1. When to call ops.dequeue()?
>
> I'm not sure whether deciding whether to call ops.dequeue() solely onwhether
> ops.enqueue() was called. Direct dispatch has been expanded to include other
> DSQs but was originally added as a way to shortcut the dispatch path and
> "dispatch directly" for execution from ops.select_cpu/enqueue() paths. ie.
> When a task is dispatched directly to a local DSQ, the BPF scheduler is done
> with that task - the task is now in the same state with tasks that get
> dispatched to a local DSQ from ops.dispatch().
>
> ie. What effectively decides whether a task left the BPF scheduler is
> whether the task reached a local DSQ or not, and direct dispatching into a
> local DSQ shouldn't trigger ops.dequeue() - the task never really "queues"
> on the BPF scheduler.

Is "local" short for "local or global", i.e. not user-created?
Direct dispatching into the global DSQ also shouldn't trigger ops.dequeue(),
since dispatch isn't necessary for the task to run. This follows from the last
paragraph:

  Note that, this way, whether ops.dequeue() needs to be called agrees with
  whether the task needs to be dispatched to run.

I agree with your points, just wanted to clarify this one thing.

>
> This creates another discrepancy - From ops.enqueue(), direct dispatching
> into a non-local DSQ clearly makes the task enter the BPF scheduler and thus
> its departure should trigger ops.dequeue(). What about a task which is
> direct dispatched to a non-local DSQ from ops.select_cpu()? Superficially,
> the right thing to do seems to skip ops.dequeue(). After all, the task has
> never been ops.enqueue()'d. However, I think this is another case where
> what's obvious doesn't agree with what's happening underneath.
>
> ops.select_cpu() cannot actually queue anything. It's too early. Direct
> dispatch from ops.select_cpu() is a shortcut to schedule direct dispatch
> once the enqueue path is invoked so that the BPF scheudler can avoid
> invocation of ops.enqueue() when the decision has already been made. While
> this shortcut was added for convenience (so that e.g. the BPF scheduler
> doesn't have to pass a note from ops.select_cpu() to ops.enqueue()), it has
> real performance implications as it does save a roundtrip through
> ops.enqueue() and we know that such overheads do matter for some use cases
> (e.g. maximizing FPS on certain games).
>
> So, while more subtle on the surface, I think the right thing to do is
> basing the decision to call ops.dequeue() on the task's actual state -
> ops.dequeue() should be called if the task is "on" the BPF scheduler - ie.
> if the task ran ops.select_cpu/enqueue() paths and ended up in a non-local
> DSQ or on the BPF side.
>
> The subtlety would need clear documentation and we probably want to allow
> ops.dequeue() to distinguish different cases. If you boil it down to the
> actual task state, I don't think it's that subtle - if a task is in the
> custody of the BPF scheduler, ops.dequeue() will be called. Otherwise, not.
> Note that, this way, whether ops.dequeue() needs to be called agrees with
> whether the task needs to be dispatched to run.

Here's my attempt at documenting this behavior:

After ops.enqueue() is called on a task, the task is owned by the BPF
scheduler, provided the task wasn't direct-dispatched to a local/global DSQ.
When a task is owned by the BPF scheduler, the scheduler needs to dispatch the
task to a local/global DSQ in order for it to run.
When the BPF scheduler loses ownership of the task, either due to dispatching it
to a local/global DSQ or due to external events (core-sched pick, CPU
migration, scheduling property changes), the BPF scheduler is notified through
ops.dequeue() with appropriate flags (TBD).

Thanks,
Kuba
