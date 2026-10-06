Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198A63515FA
	for <sched-ext@lists.linux.dev>; Tue,  6 Oct 2026 20:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791319463; cv=none; b=QqFaSu+ujOEbZPCaNMYgeW6/ZQM9GA1rWfVsaiTFHz2E5wExqqnu3EOEQjS1FCcn4UV502jaPltkHQiYI0Vs9MROm2HG9zRZgs1OwmfrapHx/iYq375H82N3pvKp+RcVxjljnBQQSIaC3s7R0Dqbrrtjww74KHxznXzYhme6MbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791319463; c=relaxed/simple;
	bh=T74DeRVu3IsKaQATR/tMd4frFhFF7yAmdgQwB4aAffc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=llPjo5piOfDmMWERlDshLdELGugt1wJcio+64UgyQffsZ+zWSCWJkfHxhcXjXQYFn81rlOU5eBl0HeShoXixp/uGqEIJ/6l3qRqDUabnMjWG+zdrJjFlbP+V2sJs3viVLxonTl3sXlp6VTRsbCEeRyHsqhfD3tGL5VviJMGBOrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fiGhw85C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fiGhw85C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C631F0089D;
	Tue,  6 Oct 2026 20:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791319461;
	bh=AX95XmBHHvtMoroZYezAaBYpw00CKgaWhtReTqZxevA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fiGhw85CHCvi3sY/d1HVgwyqRb+W5YZQohLodVdLDuovQtbqY6sNW15N9Qddf1+Kq
	 2ggThUWXqWYmFr6Cyg/Ai6XSQECV53JtnzGtOjZuhyuh59d7X7KIgAFA9npPsuls4O
	 lKEUBxWXQA9snaTeHXxGgPbjN7rWxz+pyI2tlLcHR6Mmjfo8JHaNoN7PQMoZyV875J
	 HzPnp3/hIPm9qg6M/Ym6KE8HkOhrSW+G+lIdgMuGCwJ35vpWojYxNZlQDsFzi/6B+r
	 Jl/VTGS2QZn5VWItTo6Vnf92mUb+t7F4iCHkaUqo2xYB2bhepS9iqJPzFNLa2N7UuV
	 s3M5uNwLhbBnA==
Message-ID: <sashiko-outbox-162439@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH sched_ext/for-7.4] sched_ext: Clear a sub-scheduler's
 caps before ops.sub_detach()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <b46300eda6da03d56262fcdcbfc9b4fa@kernel.org>
References: <b46300eda6da03d56262fcdcbfc9b4fa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 20:44:21 +0000
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] cleanup: mixing goto-based error handling with guard() declarati=
ons in scx_bpf_sub_grant()
--

commit 289fe25628ccca2188e3c04a46e7f9601f2bbbe1
Author: Tejun Heo <tj@kernel.org>

sched_ext: Clear a sub-scheduler's caps before ops.sub_detach()

This commit clears every capability of a sub-scheduler before calling
ops.sub_detach(). This ensures the dying sub-scheduler cannot modify
state after the parent has cleaned it up.

> diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
> --- a/kernel/sched/ext/sub.c
> +++ b/kernel/sched/ext/sub.c

[ ... ]

> @@ -2321,6 +2355,12 @@ __bpf_kfunc s32 scx_bpf_sub_grant(u64 cgroup_id, u=
64 caps,
>  		scoped_guard (raw_spinlock, &pps->lock) {
>  			guard(raw_spinlock_nested)(&cps->lock);
> =20
> +			/* the child is being disabled, see clear_all_caps() */
> +			if (unlikely(READ_ONCE(child->aborting))) {
> +				ret =3D -ENODEV;
> +				goto out;
> +			}

[Severity: Medium]
Does jumping out of the scoped_guard() and guard() scopes using a goto
violate the cleanup subsystem guidelines?

According to the cleanup subsystem documentation, the expectation is that
usage of goto and cleanup helpers should never be mixed in the same
function. This pattern creates confusing ownership semantics.

> +
>  			/*
>  			 * Narrow granted_cids to cids the parent holds every
>  			 * requested cap on. All-or-nothing per cid.
> @@ -2373,9 +2413,10 @@ __bpf_kfunc s32 scx_bpf_sub_grant(u64 cgroup_id, u=
64 caps,
>  		}
>  	}
> =20
> +	ret =3D any_denied ? -EPERM : 0;
> +out:
>  	caps_updated_deliver(&to_deliver);
> -
> -	return any_denied ? -EPERM : 0;
> +	return ret;
>  }

[Severity: Medium]
Could this goto-based cleanup label be avoided to adhere to the scope-based
cleanup guidelines? Since this function now mixes goto cleanup with guards,
should all resources be converted to scope-based cleanups, or should the
goto be refactored?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/b46300eda6da03d5626=
2fcdcbfc9b4fa@kernel.org?part=3D1
