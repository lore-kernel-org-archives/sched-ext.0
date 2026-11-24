Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795560797;
	b=V/zDBG89noKPbQqiEGuSCnjOs1CChYSOzqs/nT8PlG0wkAmTSiFRuLrwiBsLS5qQrMPF
	 0Da2AXmBKyhuH735YclzsCfbHZ9+PIEnh94poZvwSP2qyHH+t3+QfSNQKUzQv7NEoCYrl
	 AFZbuATPkSq+1TWSBotpwIA5nteEiUTLYG07w7rRFkqT+SzZrf/ucVnpqzFqKp7beYQhU
	 t4F8aLAaMBdFONgzqjv4sawRFD9WezzWO1sS9dTLI+k/9EE+W5NNjVvQ0mDbosZcqPmpF
	 kaA3t5Jq2MAkx6NO/T5AkIyGdghoMUyT00nyAZbzdzzeBUKBGYHefZAUfowuNBtis7g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795560797;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=62HWMZceS0oj2mWZkMmwxpsPh7opOIuDf/S593U+xIc=;
	b=1XcjThPv/9d2uAJMhuPmkIXpO4hISYI+arMQq2pto2YFt+gnxgXOrf2CWHcXkQtEoWLZ
	 ujrsKWryFHcGR9JuWzsX7iApVhu57i5wf+CjnO3zlHsq9WPBKfB6xvIM5WoKIsopgNwlY
	 KvF05rM8oROERe4Ktc0I7JAIqxfP7d3j7Ow2Zu/eZaMboPQ0biSUceVTni6+8K7TtcnLi
	 mFwjn5GOzW3m+D1hVt3G9agLg18Ftj+Vy9gslDmXMz6YQ3HZlktniUcCRJF7r2v0zhbSk
	 W5L8Z+VhqkMVATA4SBzsvVLnzd+DwYhVIQTwuUF/y+ruYRu74f8P+Lrb7CKmSS3sA6g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VkcUttmg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE9D606A321
	for <sched-ext@lists.linux.dev>; Tue, 24 Nov 2026 22:53:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AE9D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VkcUttmg
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48e3b22e971so2673905f8f.0
        for <sched-ext@lists.linux.dev>; Tue, 24 Nov 2026 14:53:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795560795; cv=none;
        d=google.com; s=arc-20260327;
        b=mZCqAaPIQyAfrnvcTrZVBedxpogIpDXmniCu9kilgTCJycsRY6SJaQndcgh+xWRJl5
         HUQbUIdg5HmmiePULOJaX5hP0a3RwjEe1KzVF0DUbr1c71TBgOq2iOjHDIhi+nKKlsEe
         9m+qcCREHY64oFpj8wuOXS+amlm9UzMj6zZhC3glqn6jOsS9pJQt4dKNLOORl0XvYLNN
         mDxhhEnPPYnHQFjqNIsS6tfaSHKHNk0BmzC3kyqCP2XlYyjzNxXsf8ZUMvzX8bsxENCH
         DHz33Vi855njK9KDDLgRvy1rudd+ULadMzB9/xK8RF8k2GRoZb4/4JsnxZd1wQ81oRyw
         2e7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=62HWMZceS0oj2mWZkMmwxpsPh7opOIuDf/S593U+xIc=;
        fh=dZ6864j2TLfk+O2zyHNoRf9B5rcRbN1/CslD/J46jiw=;
        b=hIu2uqTFiI9sLL5NdGcfVlDH321UH9xdyJ+rNBocBj2322mVoeIZ+ic/FOIzHSxAt8
         Y6GQBe9xlLO/qB3CGW2ozHHdKFqKnY31Cyz2cHBlngv3/OytxVqUaoMA/uRa2znXN1t6
         /8Vn8eMdBgx5gfaUOkspO/QohccalcRVheJUymTwWMj4mULFGk3HcKxnxCc2mkVrgu61
         NtdWoxHPEm4vSGVRA0FpJ2pQMkxO7vvEaxj7fugFDU8wOgZhpgbvjtGlhU0kL7U81vbW
         l0Hes09PKTALHpRI9+DEe0sk+lcmekjW8wSs8U6CGvpcv/4U0Zyeng3P91ybInifuJoz
         VuZA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795560795; x=1796165595; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=62HWMZceS0oj2mWZkMmwxpsPh7opOIuDf/S593U+xIc=;
        b=VkcUttmgUTThuJoBibXxE9GLQdpw+H5bwnDdzswSaYjYV10dnmINiVmEL1tD68d4x0
         OMYJNZzNtHI6h7tJoNd3F2gruVas9+fgZyno/DoMN27ApTFNSf0nHSM+v9QrWsI1EWid
         0b9BULJLLj8KrQ/R6RK66jsSQouF7yOLQu5eGhvF3RqRZHmtNqSrmiW9d1hT6gtSmB+x
         dbs6qhnWt/+7dU3c6u/SMapQ1j/oSZJ/Pmh/holh/tyKTk8Zu++5TEZxQwpB0fxkufbL
         LVagWRZRO/9ODYAZw9SggcaLxF4Q1tIiXTMfXsbJwReuBT3t4K7pM+nxkNGi/zay1lDM
         GCaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795560795; x=1796165595;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=62HWMZceS0oj2mWZkMmwxpsPh7opOIuDf/S593U+xIc=;
        b=s0qaPMOtiAv8pOVUyRARR8bRiRpO3XOWfGNI2cibS+7WmJXmv5Eer5j/5Y/owSrkc8
         1fGpUZj35F5TfL4d4IiE0hsgI9dYAaG8dBVGwntifiBxCxLa3MPwMtB7WroBy0/rCI7v
         ayX+ychwt9rq9RN7EyWRTPppG6+xpD95Fsz45O1qHnciiRptQ/1PA8RCA6qjuRFSjPJg
         LX444ZLFY3gZrEs2OdAzYpoERe8G1ZdbEpANkVg3gYsaJTwmzcSOjZ/PzaLWhlSwNPIE
         yTTJWNBAsO6x12woSclW8B30FlzBsmMvfhZsiRwD7sgThaAc4o1/GU3fj3if5GXk7KOu
         +bVg==
X-Forwarded-Encrypted: i=1; AL+hErFkVpPu92ylqT73CeFZJwRcgDPNDLqKFMag/izcPSNJAukKPr6KlcSxFy17GhTDOLJOrn+z8gkT/Dk=@lists.linux.dev
X-Gm-Message-State: APuU4Z/NgekLP/U4jMiGZh6yMyENNJd4HamG2l9LeNuJElbuXhjiNd/C
	c372jKqzMPHRtAVB92I2wsbivIS/pXLofDRnvxAYOfanjaWvRr4S12xh+pT5Ore5KZi16kNldd8
	nbqanhaqNzRuDNYYZgQwYQPdtdmWtfdE=
X-Gm-Gg: AZFdTZcgRonnZESo9zAOz7SfKtzJ2jKrBZduUdBQ+QeYAQEylrqu4mh/aZdagrrdM4a
	2rp8y+rtDZBy+rEHqjKOxBcPEAEGgcSlbfyVO3vj6DS2dLTsSny2kI24LU5n9fhrIv58laWJi04
	/JvObF2Vgh+IeIZurU28qpFc+PYQ2bPttLOKSJ+94OBn1lKfNb/lTHj/x6AquYAvyl5CZDDZpR+
	e4JKFR1ZrtO+UfhLZXaQv23EXWi/7H/+wTsdvaROo+AJNJ30wnhXd0G1khkPnF8mBxXJeBuRn8N
	EngD+b3tIDzCXGiQcYjl/Xe9NCaNlfzonmSyJVpbBl+0/d7pbELrvTIQ1YSlbeRPFZG+TJ8xDE0
	Dulgt/5dJkCy9ZcjA55IJZZRnIWUjsulgKM/ir1KjkfFxPzkLJmbDSJ97H8MRkWRFMnnMhWm8+r
	QX+GW2YZE3pO3oMnZn/xSfPh50dY0vahLTQdqyTZQ=
X-Received: by 2002:a05:6000:491b:b0:490:9fe2:6a2d with SMTP id
 ffacd0b85a97d-4abb0a710c2mr29944554f8f.26.1795560795520; Tue, 24 Nov 2026
 14:53:15 -0800 (PST)
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261124224811.16134-1-ihor.solodrai@linux.dev>
 <20261124224811.16134-2-ihor.solodrai@linux.dev> <10ad779b-708b-4b0b-b6af-54f3d7414f82@linux.dev>
In-Reply-To: <10ad779b-708b-4b0b-b6af-54f3d7414f82@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 24 Nov 2026 14:53:03 -0800
X-Gm-Features: Aa3M54rYfCcMSZKLBapkSyA5aPNL8Tahfm5y46F16UVYrsj2TNZk7O-pDyWMN8o
Message-ID: <CAEf4Bzbn5Wk6q3MWpryLSZtFaPq3tGh+kfuWQGTSv8joE996vQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/6] libbpf: Separate interfaces shared with
 in-tree tools
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Jiri Olsa <jolsa@kernel.org>, Song Liu <song@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 2:50=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> On 2026-11-24 3:48 p.m., Ihor Solodrai wrote:
> > resolve_btfids and bpftool link libbpf statically and use some of its
> > internal helpers from libbpf_internal.h. That header also defines
> > logging macros and poisons kernel integer typedefs, so resolve_btfids
> > wraps the SHA-256 helper in a separate source file.
> >
> > Move the declarations these tools use to libbpf_tools.h and include it
> > instead of libbpf_internal.h. The header is for in-tree tools and stays
> > uninstalled. No shared-library symbols change.
> >
> > No functional change.
>
> I posted v3 with the refactoring as described in my comment [1].
>
> However now I'm thinking it might be an overkill. With the re-design
> vs v1, resolve_btfids now only needs btf_kfunc_proto_match(), if it
> includes relo_core.h, so the new libbpf_tools.h is not as appealing.
>
> Speaking of "API levels", libbpf_internal.h has already been
> functioning as the "in-tree users only", and there is another special
> user among those: the selftests (see paste below). So if v3 is landed
> as posted, we now have two "levels" of in-tree users.
>
> It's... fine, but not exciting. Adding libbpf_tools.h doesn't help
> that much, and dropping it doesn't hurt. It's all bikeshedding, not
> directly relevant to the series, ultimately caused by name collisions
> between resolve_btfids and libbpf (u32 poisoning and pr_* macros).
>
> Quentin, Andrii, Eduard, please let me know if anyone has a strong
> preference here, I'm happy to respin. Thanks!
>

heh, we raced to the minute. I don't like libbpf_tools.h approach, if
GCC poison is a problem I'd rather guard that.

don't respin just yet, let Eduard do a pass at least


> [1]
> https://lore.kernel.org/bpf/faecfef3-ac9f-41be-8bc3-83a66572066a@linux.de=
v/
>
> $ grep -rl --include=3D"*.[ch]" 'include.*libbpf_internal.h'
> tools/testing/selftests/bpf
> tools/testing/selftests/bpf/prog_tests/bpf_obj_pinning.c
> tools/testing/selftests/bpf/prog_tests/btf_field_iter.c
> tools/testing/selftests/bpf/prog_tests/btf_sanitize.c
> tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c
> tools/testing/selftests/bpf/prog_tests/cpu_mask.c
> tools/testing/selftests/bpf/prog_tests/fill_link_info.c
> tools/testing/selftests/bpf/prog_tests/get_smp_processor_id.c
> tools/testing/selftests/bpf/prog_tests/global_data_init.c
> tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> tools/testing/selftests/bpf/prog_tests/kprobe_multi_testmod_test.c
> tools/testing/selftests/bpf/prog_tests/module_fentry_shadow.c
> tools/testing/selftests/bpf/prog_tests/perf_branches.c
> tools/testing/selftests/bpf/prog_tests/perf_buffer.c
> tools/testing/selftests/bpf/prog_tests/raw_tp_test_run.c
> tools/testing/selftests/bpf/prog_tests/recursive_attach.c
> tools/testing/selftests/bpf/prog_tests/sha256.c
> tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
> tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> tools/testing/selftests/bpf/prog_tests/signed_loader.c
> tools/testing/selftests/bpf/prog_tests/tracing_multi.c
> tools/testing/selftests/bpf/urandom_read.c
> tools/testing/selftests/bpf/urandom_read_lib1.c
> tools/testing/selftests/bpf/trace_helpers.c
>
>
> >
> > Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> > ---
> >   tools/bpf/bpftool/Makefile            |   6 +-
> >   tools/bpf/bpftool/common.c            |   2 +-
> >   tools/bpf/bpftool/gen.c               |   3 +-
> >   tools/bpf/bpftool/prog.c              |   2 +-
> >   tools/bpf/bpftool/xlated_dumper.c     |   2 +-
> >   tools/bpf/resolve_btfids/btf_colors.c |  15 +--
> >   tools/bpf/resolve_btfids/btf_colors.h |   4 -
> >   tools/bpf/resolve_btfids/main.c       |   5 +-
> >   tools/lib/bpf/libbpf_internal.h       | 162 +----------------------
> >   tools/lib/bpf/libbpf_tools.h          | 184 +++++++++++++++++++++++++=
+
> >   10 files changed, 199 insertions(+), 186 deletions(-)
> >   create mode 100644 tools/lib/bpf/libbpf_tools.h
> >
> > [...]
