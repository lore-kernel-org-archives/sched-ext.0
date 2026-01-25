Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C4A1EF39E
	for <sched-ext@lists.linux.dev>; Sun, 25 Jan 2026 03:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769312255; cv=pass; b=I7HD+mTYh9RcjOykVX0/uOs6i6vpGCQjlHEnoD+jyT1gGRjP9sBTKMs63RRkgOpFynbQJ3N40xbT3cQXjwMLbuQKgqIA4loqtjJ0WtrXjCtbzHAj0rpFO5rjgbjw0hqc+fBmL5aXe4LAUTpdYrcvd2ihtQmfY05RMVAmm0YpSEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769312255; c=relaxed/simple;
	bh=KHHLDqior8B1P737y/3GiXhhM05h77Asbm7hlK7XFjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jwvydNyeBbVCf8xeYAhU4D1XSFQH5nwpKEKdFZfnsI7jaxS1E6Klrc8rv7dkNMBCoM/kx5gsblywkg5P+GmHgCZUEjRtGL7DD5s2g7xUza+I83ZbScPS3IXdZNkNKiUjgPSL8frOlMoi12yod3YlRg73WJXy5ymvRiUgm2in/bA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HxmMR/+N; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxmMR/+N"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47ee937ecf2so28944325e9.0
        for <sched-ext@lists.linux.dev>; Sat, 24 Jan 2026 19:37:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769312251; cv=none;
        d=google.com; s=arc-20240605;
        b=cJZp2jJnbtVbfG2vS5rVjrFDbCVDR/A8p/McNQKecBjxl2e1GIQs/McxRxf8nGmr1Y
         CyEQTWOKTaCjeRoLosOhQOQ3U56HFtVt/fTHmR/Jgbmn91a8HjlUqVVybOkHgnk55N5Z
         haRsasIvHhrEW2EGspSzQbsGlinD/jWr/WMhEyZ1TG309iSRwF5iyVwxw+HAra9lhPjn
         iryH+VhZJyveFtUFo91BHN2JbjMoza42v614AzCAAdwQ28MpQnspg6u7H7/+IjzdcYcD
         viTtz0KLHqLmAik3Rag9cvD5+YF6Wr3YAFQlLiG1nI3qZSjUbXV72jFmPnCDiVy5so6F
         XBiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fPmCud2y+M6bkRgBEaGbRSzSQM5OP3Xz+/rlIQC+PcY=;
        fh=trZz8xCCcUVE3F76dYnVXEaIztXfxtJGi7GfCw8B3AM=;
        b=lauZFUn7O6NwPqMjD8keSSLeunvf2A8I2dJ8wHrhEwrYzv2fTPx3c4pRhN4OiCyio9
         2tUT6F2aSEIKzWCetmNnammA2xarDgJdsPOIgXLBa4EAkoqUTHcX3G17g1OViAyRONxV
         M4Z8caGspPz3cwB5ty2q+EV4GTFAs8Q4gBhM7uXg/Vn85vfAb27uFJGMVfI3Vmn3kcMh
         pF3iUuCUwXdgdvSN5CNArHtHaFeYkVwfmCVwXvFMaOMGH5zWdbuqVPFnf3ZateOG6To3
         EAu6RanPLAJAEcjhvAa3v5kWptw1QaoSmmNQFEApfj+AeTkqREaFWdXEsxQItffTIhLY
         Ir6g==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769312251; x=1769917051; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fPmCud2y+M6bkRgBEaGbRSzSQM5OP3Xz+/rlIQC+PcY=;
        b=HxmMR/+NxvJAvJsQhwSKpuEpJft0Ip8pm99LB9ns9QR2H7dIJJA/jyd/c3go3lcK/8
         NDqeCnV/c7PX+lPjMyFKox/17X1LeoN+UcPclmIaD57yzFmxEJt4Ls+wqqArt4tAp+59
         PfWlWJu0x3+x4HmB7TLXl5syiPVVsOHhELlnBHBSE0T0JW2xdBt3EUBc2bJhtbGMOXvn
         UEulHGLGhTHyT2gTSoA0gTr7SbmMHF65XdYcqwfkQHuSe/oXrBAQVafVGrcDK3pWwQH+
         e3hqy2QHG79Wa3GgEqGBXn4HbI+EEG4UxJ4BDiUWVZ7mEMbcrYUwNEDqnkHyeai0jJRM
         a89Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769312251; x=1769917051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fPmCud2y+M6bkRgBEaGbRSzSQM5OP3Xz+/rlIQC+PcY=;
        b=NJGTC0a7wMnkRVDJ7StHf328VTBlKMdJHdru4C0MdXiG00UaSoCqdr581lJE3y/MJb
         w3IDMfsMTXlRtZsTQ+u0zQZKcBkKwZtMx9ke9eEHhf7+yRmOSTB/h009EVmV8cIFv7i1
         vWDKj7OOU/Bmw1HpHQhT9wS0LIzbZCpGvaPkUhFJThHQnpt15M6XnKSkl3MYVybgg7ki
         zSLx403UVoaRayVqdhGVkSO6vuaJKD206+Vxmlg1lD7zBOFee4jLkTMzWBZaPT87xiIN
         ZcGNal1ilkk1B3RYwGNa8KAFLJSHPE+/g2LpHxUUUhC2kzC0kB9B7O824DmRl50ySfmC
         bbDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLxhiaA2hO+RbyCLtfUa/J39PCEGW4o3R46L5GaiVq6LlqtgIDf1civhdyVEOk4U9i6c/GVJ1ixWE=@lists.linux.dev
X-Gm-Message-State: AOJu0YwPZyNm/VdIIz/SYln/pdrVAUqkP0zLIU/7VOkZMcHvYa6VdHQj
	dfuPqKtyZSjdvyr8ROXbVaTOeWE641epUyrT0k1urpdIo4vG8Xgvbz4lJNQQJe8A7BJHap7OLHz
	oTT424aWV04v/MLir0FYkTKCrW9LEL50=
X-Gm-Gg: AZuq6aJEzaNOQLvpuI+Ci2tnlpdClMyThYh6ndczdw091GQ5ujRNefUj3Qe+bbP17o9
	0umnUdglya8mDZmBdFpjyWekCeW7bsDk1k1SL1MEYHORWdSC76wwU+5ogjae2s8gDnLyu5eQwce
	iuS3idc967nITFcasWrLv0fAWGF6xdFjRcRv17khnIJ6lpSKcD92kc1aXkAOSWqUgjZPCbeQ0lh
	ilOjMnv6dJr3aLDzKbUR0IAQh3uh7CBTBP0xLvqSINzIZckUsFMNuI+ENAAR+kv2gGrPqGnEYRb
	QdJC5YfKdBT9YuyqMM844SOSdx9qZfUHfWLsirz7785ht5OEBEggQ7HDmh5MGaKgw8xydzkDt8l
	RWUEe+dB0XFBNI4DYmE9X+wVy
X-Received: by 2002:a05:600c:4e0a:b0:480:1c1c:47d6 with SMTP id
 5b1f17b1804b1-4805cd209b4mr8106025e9.6.1769312251203; Sat, 24 Jan 2026
 19:37:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260124132706.183681-1-changwoo@igalia.com> <20260124132706.183681-3-changwoo@igalia.com>
In-Reply-To: <20260124132706.183681-3-changwoo@igalia.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 24 Jan 2026 19:37:20 -0800
X-Gm-Features: AZwV_Qj31pcX5ZPXwbOsYn_O2QL4zbHL9yGaFvSAbSLaqW3XuIfAe1fsD78xc_g
Message-ID: <CAADnVQLS4n+Mnti34aaN9_k08WLV0fj_2AM61x-oApFKwKGihQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Add tests for execution
 context helpers
To: Changwoo Min <changwoo@igalia.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, kernel-dev@igalia.com, 
	bpf <bpf@vger.kernel.org>, sched-ext@lists.linux.dev, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 24, 2026 at 5:27=E2=80=AFAM Changwoo Min <changwoo@igalia.com> =
wrote:
>
> Add a new selftest suite `exe_ctx` to verify the accuracy of the
> bpf_in_task(), bpf_in_hardirq(), and bpf_in_serving_softirq() helpers
> introduced in bpf_experimental.h.
>
> Testing these execution contexts deterministically requires crossing
> context boundaries within a single CPU. To achieve this, the test
> implements a "Trigger-Observer" pattern using bpf_testmod:
>
> 1. Trigger: A BPF syscall program calls a new bpf_testmod kfunc
>    bpf_kfunc_trigger_ctx_check().
> 2. Task to HardIRQ: The kfunc uses irq_work_queue() to trigger a
>    self-IPI on the local CPU.
> 3. HardIRQ to SoftIRQ: The irq_work handler calls a dummy function
>    (observed by BPF fentry) and then schedules a tasklet to
>    transition into SoftIRQ context.
>
> The user-space runner ensures determinism by pinning itself to CPU 0
> before execution, forcing the entire interrupt chain to remain on a
> single core. Dummy noinline functions with compiler barriers are
> added to bpf_testmod.c to serve as stable attachment points for
> fentry programs. A retry loop is used in user-space to wait for the
> asynchronous SoftIRQ to complete.
>
> Signed-off-by: Changwoo Min <changwoo@igalia.com>

...

> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include "bpf_experimental.h"
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +extern void bpf_kfunc_trigger_ctx_check(void) __ksym;
> +
> +int count_hardirq;
> +int count_softirq;
> +int count_task;
> +
> +/* Triggered via bpf_prog_test_run from user-space */
> +SEC("syscall")
> +int trigger_all_contexts(void *ctx)
> +{
> +       if (bpf_in_task())
> +               __sync_fetch_and_add(&count_task, 1);
> +
> +       /* Trigger the firing of a hardirq and softirq for test. */
> +       bpf_kfunc_trigger_ctx_check();
> +       return 0;
> +}
> +
> +/* Observer for HardIRQ */
> +SEC("fentry/bpf_testmod_test_hardirq_fn")
> +int BPF_PROG(on_hardirq)
> +{
> +       if (bpf_in_hardirq())
> +               __sync_fetch_and_add(&count_hardirq, 1);
> +       return 0;
> +}
> +
> +/* Observer for SoftIRQ */
> +SEC("fentry/bpf_testmod_test_softirq_fn")
> +int BPF_PROG(on_softirq)
> +{
> +       if (bpf_in_serving_softirq())
> +               __sync_fetch_and_add(&count_softirq, 1);
> +       return 0;
> +}
> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools=
/testing/selftests/bpf/test_kmods/bpf_testmod.c
> index d425034b72d3..1b04022859b7 100644
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> @@ -1164,6 +1164,33 @@ __bpf_kfunc int bpf_kfunc_implicit_arg(int a, stru=
ct bpf_prog_aux *aux);
>  __bpf_kfunc int bpf_kfunc_implicit_arg_legacy(int a, int b, struct bpf_p=
rog_aux *aux);
>  __bpf_kfunc int bpf_kfunc_implicit_arg_legacy_impl(int a, int b, struct =
bpf_prog_aux *aux);
>
> +/* hook targets */
> +noinline void bpf_testmod_test_hardirq_fn(void) { barrier(); }
> +noinline void bpf_testmod_test_softirq_fn(void) { barrier(); }
> +
> +/* Tasklet for SoftIRQ context */
> +static void ctx_check_tasklet_fn(struct tasklet_struct *t)
> +{
> +       bpf_testmod_test_softirq_fn();
> +}
> +
> +DECLARE_TASKLET(ctx_check_tasklet, ctx_check_tasklet_fn);
> +
> +/* IRQ Work for HardIRQ context */
> +static void ctx_check_irq_fn(struct irq_work *work)
> +{
> +       bpf_testmod_test_hardirq_fn();
> +       tasklet_schedule(&ctx_check_tasklet);
> +}
> +
> +static struct irq_work ctx_check_irq =3D IRQ_WORK_INIT_HARD(ctx_check_ir=
q_fn);

Nicely done! selftests should work in PREEMPT_RT too
though we don't enable it in bpf CI.

I was about to apply it, but the new tests fails on s390:

test_exe_ctx:FAIL:hardirq_ok unexpected hardirq_ok: actual 0 <=3D expected =
0
test_exe_ctx:FAIL:softirq_ok unexpected softirq_ok: actual 0 <=3D expected =
0

The existing bpf_in_interrupt() also works on x86 and arm64 only.
When it was introduced it came with pretty weak selftest
commit 31329b6 ("selftests/bpf: Introduce experimental bpf_in_interrupt()")
so it's not really testing anything on s390 and non-x86/arm architectures.

So just add your strong selftests to DENYLIST.s390x.
get_preempt_count() on s390 looks like this:
static __always_inline int preempt_count(void)
{
   return READ_ONCE(get_lowcore()->preempt_count) & ~PREEMPT_NEED_RESCHED;
}
but get_lowcore() needs asm.
So it's not going to be easy to make it work purely in bpf.
Let's punt it to people that care about s390.

pw-bot: cr
