Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA44128816
	for <sched-ext@lists.linux.dev>; Sat,  9 May 2026 20:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778357788; cv=none; b=IoFzgz/LE3OB0sH3rOYiyX3sBOOHvO9WejboXRhqw717+1eRMQCwKvqgWstOhz1cwwyLX+BPFeePFcUsaLlAOi/WC+sBO/vysT5boLuXPSnPvn5+1R0QcrM+7bjSgdh/aEWHWW7FW+8/ZeGSFz2xTBczTSfgdtgkIb4i/2sN/J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778357788; c=relaxed/simple;
	bh=C93MUd1ycoUxkixGOMxk/Y6YJpz5PqYEleQwrATKI6E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bx33QbmLDQgcdxTQGum20ucjrRPArXgIAzEntz6YQb8Wos9FwyB6/5kw982+f7w0qrjM2Yv3En1inPMAKpc5oPvxvtogypOFakIC1JIlUKpSfGCOliRn1ghzzThQhORexLrakAIyAdCRoQcdGE1RY0Po9gbrjq4oWp3vWB1vUps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/j+1GQ4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/j+1GQ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 951A0C2BCB2;
	Sat,  9 May 2026 20:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778357787;
	bh=C93MUd1ycoUxkixGOMxk/Y6YJpz5PqYEleQwrATKI6E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=s/j+1GQ4j9pe2RBR6ITxybsieIYRxzVbjoX2UF2E4jtIO+YN+sTi2/gBNfxtnXnMZ
	 /FrFxs3tVpyv06xQHS0iXb2HWBra54SlUXWNNyjWbvMeTH34x2MoREmWGFezOuAYc5
	 kTL6ti5xat3uIrehBoQmo4Rv+0TGYPc93GkfuTLALut/O3qH3OGwhKOSGDMDaFZdno
	 5WZpQ5n79038NqGbHZRc7vqgsRDw3LJrAvzbATzllGikK/2ZjQGomT+3Xz9XgsmKI1
	 Hfy8vvZu7B8XOhOB04IIm4dUwpX6Kv4Fcx5Z201cSRyH+WM1qbRDZ0Yt8LEvvzPj3X
	 NYXXe7LKmL+Cg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] selftests/sched_ext: Add dispatch_cookie test
Reply-To: sashiko@lists.linux.dev
To: "Cheng-Yang Chou" <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260509191223.168648-3-yphbchou0911@gmail.com>
References: <20260509191223.168648-3-yphbchou0911@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 09 May 2026 20:16:26 +0000
Message-Id: <20260509201627.951A0C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] `scx_bpf_dsq_insert_commit()` is incorrectly called with `SCX_SL=
ICE_DFL` as the `enq_flags` argument in the test.
--

commit 080e78551f77aa8abf00b5d2d1e0d0b5fa62c1b7
Author: Cheng-Yang Chou <yphbchou0911@gmail.com>

selftests/sched_ext: Add dispatch_cookie test

This commit adds a new BPF scheduler selftest to verify the behavior of the
scx_bpf_dsq_insert_begin() and scx_bpf_dsq_insert_commit() APIs.

> diff --git a/tools/testing/selftests/sched_ext/dispatch_cookie.bpf.c b/to=
ols/testing/selftests/sched_ext/dispatch_cookie.bpf.c
> new file mode 100644
> index 0000000000000..ed31cddcda7b6
> --- /dev/null
> +++ b/tools/testing/selftests/sched_ext/dispatch_cookie.bpf.c
[ ... ]
> +void BPF_STRUCT_OPS(dispatch_cookie_dispatch, s32 cpu,
> +		    struct task_struct *prev)
> +{
[ ... ]
> +	stored =3D bpf_map_lookup_elem(&last_token, &pid);
> +	if (stored) {
> +		token =3D *stored;
> +		bpf_map_delete_elem(&last_token, &pid);
> +		scx_bpf_dsq_insert_commit(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, token);

Is SCX_SLICE_DFL intended to be used as the enq_flags argument here?

Looking at the function signature in kernel/sched/ext.c:

bool scx_bpf_dsq_insert_commit(struct task_struct *p, u64 dsq_id,
                               u64 enq_flags, u64 token, ...)

It appears scx_bpf_dsq_insert_commit() does not take a slice parameter
like scx_bpf_dsq_insert() does.

Since SCX_SLICE_DFL is a time slice duration, passing it into the enq_flags
parameter might inject undocumented garbage bits into the scheduler's
enqueue operation. Does this unintentionally alter the enqueue behavior?

> +		scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, 0);
> +		__sync_fetch_and_add(&nr_tx_stale, 1);
> +	} else {
> +		token =3D scx_bpf_dsq_insert_begin(p);
> +		if (scx_bpf_dsq_insert_commit(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, token)=
) {

There is another instance here where SCX_SLICE_DFL is passed as the third
argument to scx_bpf_dsq_insert_commit().

> +			__sync_fetch_and_add(&nr_tx_dispatched, 1);
> +			bpf_map_update_elem(&last_token, &pid, &token, BPF_ANY);
> +		} else {
> +			scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, 0);
> +		}
> +	}
> +
> +	bpf_task_release(p);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260509191223.1686=
48-1-yphbchou0911@gmail.com?part=3D2
