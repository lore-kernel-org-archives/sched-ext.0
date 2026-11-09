Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794237940;
	b=TvORPGpYhZzAvo0zV5DFDa6aqXn45gUn50Lfp3kDSzzFfijZvCry93spbz+HEaKV8RXF
	 yDBrWX0Tl0qcLJM3O05l06h411Vsetj5leg8+dAdviu34l+AoOjzt/JUSJKSCdCHpyrJV
	 W5OgYjru3/xu1DACNllVxeTXMuBF7ILhmyt0uuahDZKSUA8lUk8m87y3LpYzrwkDScY22
	 U84eLNkLJJ0yEFiTJ48cm9IfEfxc5QeWi4BimzkgYwNu+8EogUo0QocBpdH7+OTc7s3hU
	 bhhgGnqGepRJs19VwLnvZGfcerx00+qrlOmWkEraYHvUvSKLg4gM+/VPSDSTJlsqWaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794237940;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:X-Google-Original-Message-ID:From:X-Google-Original-From:
	 To:Cc:Subject:Date:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=+2eo50vndD4kHyto0T87+2tamN+YBpxl6Kj/Chr71eo=;
	b=VpaUaGhFzUzxkmIlr33VfnMIZHUnvVcD604eQ7QY5eFJ7TawVJ4Hg3OXxSqRt7T/AnXk
	 3nHSKUa+688VTL2Yrrc6wuJgKNTuxDpQQmH58z/CV6Jfzf2HgFxJKeL5FxYUbMgIi0oLy
	 83Y/9xXWMsOQ3GF1b5hT8BkSVrHxN0sr9gDnj6HSkeC3wU4m8QxPO/mse9RMFOHYeZi8M
	 R42Dn1xI7FPbgQAHghX9D2Z+jVtutjJ4GZP3FGpdUESaDhRIlmbYZKuja1+UiNC2gZpMK
	 4Fb1vPs0XSQ1aKSRc6xaGR/Aj2UClX92n1R8B7GgC1AS51NL9scC8ecgEwob9IzSSKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZgvMgIKN;
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0041B606A31C
	for <sched-ext@lists.linux.dev>; Mon,  9 Nov 2026 15:25:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0041B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZgvMgIKN
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cdb75699c7cso378478a12.2
        for <sched-ext@lists.linux.dev>; Mon, 09 Nov 2026 07:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794237939; x=1794842739; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:date:subject:cc
         :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+2eo50vndD4kHyto0T87+2tamN+YBpxl6Kj/Chr71eo=;
        b=ZgvMgIKN2iaG5wayAJQ0sBEgljwqN2v+8+HecFavFwLIn+2b4SrSnth9xwLtzJ0/1J
         6xuLCETRmXXXPX9Vm2eGjIHfFg8GhX5uazdvkCKqTY/HSu/8wwY7mIZ8hH6pBYAelkAD
         OrlwcX+6wRiv3siehU7kfG6w16BNGp3cAP9EfzR/zUGitafvNu7W2XSTWWs1JqPdWPvC
         MI9SOo6pg3mQP6Vimr/MYjR0qao/a9h5vChumnYitZ/x7K8hbL7JCCJNkSbpbd85M+25
         WTEa5HX5VtQYJ8wQBHcoA9pPOsviPjIVP16BPoFC4a3UDKGiXPJypfz6nCSkRhiGZ+TN
         VOOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794237939; x=1794842739;
        h=content-transfer-encoding:content-type:mime-version:date:subject:cc
         :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+2eo50vndD4kHyto0T87+2tamN+YBpxl6Kj/Chr71eo=;
        b=09LDh3fUgJA7LkWTLhckp0pdGMRISz15O1qHqfnuDYVpsf9mjzxZQvIm+7fs5wxmr0
         c7L3tIK3PUQM7YCCfV10sN3Ctz7V80FadvAWglZhJisIxqkTLNg0etO5Pwdp0SUt+rka
         TpLXaA0TKoo919jkWvnBs5JX+4/oJrNdR7k9/MGdRhWXH46jPaF94zA7/6f/xwTsoETT
         yPQglRw/90hWU/2zOu+fg+/ddifZSwfoekM2XtqFxhD1kMzr+V9AcVW5imFc8xK0GTBN
         qmi5eSvcsZ00+ATzN5C7Vvd2/5oaqj2sWkmjWvcu75VXNBP2Lz6+65YdCzwHxyItKKS+
         at1w==
X-Forwarded-Encrypted: i=1; AL+hErG6Tm2OTA/LLm1BiBwmWIRIxk9bMKmfiwj3SJKzMzT54rGhH4ICADtiH+CmOcLZ8ceMPy0H0X7V2zk=@lists.linux.dev
X-Gm-Message-State: APuU4Z9Z/5k1pbx398WT1LSHz//7p22gq6AAssm3KsYmM2RvJkaN2KWN
	4dsTGQEQYPUkPo+OjuPXTOyj2k/Hnmh8ECy9jnHRAzvZ+VS6MXtQ+ALD
X-Gm-Gg: AYBFou0wv88MIe502ZiquAgYnhIlPe1wpycPl1qFxoy+rNNnBvMM0eUsoKJisGnIzJ7
	VMpW6KoFJOjJLwmedk/ZSjxReDWua3orUn5O5sTdbh6+3i5RRbj5MUBaKzRAu4/3pNKewg+23g9
	vre46wyH2dcDf4Uc6QhrC0s7M5BlvKhf1JyX15pU901wI6QG509KILp7g238mAoz002LUjpeOuG
	FgpOayj7SzYu2syLQFTn6McS2QnZGyampOj0sqDC/7Y7Wtmm2wdxVsaksVdJcQIg49Tu42gXGpT
	HETYk3bW+XpbgZMslNfvHZUHWQLnwbriBNsIKoQrghz1sD/pf7Gil8uT2yMbB+ouDZipawGbbdq
	3gV0ELPstwNb0pvGTRVrPVu3K+wwbhJSFWJybiJRQRySRJbLxAn3R2i9uSq4Wq3XTLvdPMnUG9t
	lS1knI16eK4KQadtPYRxUcZU+TwoiLxmwGiLDy3/aInMR1dldRn9icXXIfC3xVPZzVDW6cTQdWI
	ehUfWuT5cOXjvFhqRglTGW3szCjMBagfSJ2vAJ61Nnu3W8k6WUhYC7hBwhV1mEIUOPFDgvjOwMe
	auBVMvR3hKoO+5039lqW267rnssMN8EoDXFdmJetYLqpAAfVTq4=
X-Received: by 2002:a17:90b:33ca:b0:3ac:929e:691 with SMTP id 98e67ed59e1d1-3b12d418819mr4176458a91.17.1794237938727;
        Mon, 09 Nov 2026 07:25:38 -0800 (PST)
Received: from hanzj-mi.. ([157.185.136.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b105864bffsm11462095a91.3.2026.11.09.07.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 07:25:38 -0800 (PST)
Message-ID: <6af1e5f2.a438010f.130489.ab94@mx.google.com>
X-Google-Original-Message-ID: <<179423792787.1832964.14629633117175086624@gmail.com>>
From: Zhijian Han <hanzhijian1991@gmail.com>
X-Google-Original-From: Zhijian Han <hanzhijian@zepp.com>
To: bpf@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: daniel@iogearbox.net,
	tj@kernel.org,
	ast@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	linux-kernel@vger.kernel.org,
	Zhijian Han <hanzhijian1991@gmail.com>
Subject: sched_ext selftest enable_cmask fails to load on 7.4-rc2: verifier rejects arena pointer cast from scx_enable_args.cmask_arena_addr
Date: Mon,  9 Nov 2026 23:25:32 +0800
X-Mailer: git-send-email 2.43.0
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Zhijian Han <hanzhijian1991@gmail.com>

Hello,

The enable_cmask selftest (tools/testing/selftests/sched_ext/, added in
the recent merge window via d781d1b78acf "selftests/sched_ext: Check the
cmask cid-form ops.enable() receives") fails to load on v7.4-rc2 and
linux-next-20261105. The BPF program enable_cmask_enable is rejected by
the verifier at load time:

  libbpf: prog 'enable_cmask_enable': BPF program load failed: -EACCES
  94: (61) r1 = *(u32 *)(r8 +0)
  R8 invalid mem access 'scalar'
  Verification failed: Register Type Safety: Invalid dereference

The test follows the usage documented in kernel/sched/ext/internal.h:

  struct scx_enable_args {
          u64     cmask_arena_addr;
  };

  /*
   * ... The address is a plain value rather than a typed pointer ...
   * Cast it to struct scx_cmask __arena * before use.
   */

i.e. enable_cmask.bpf.c:101:

  struct scx_cmask __arena *m =
          (struct scx_cmask __arena *)args->cmask_arena_addr;

The C cast does not emit an addr_space_cast insn: in the generated
bytecode the member load (insn 1: r7 = *(u64 *)(r2 + 0)) produces
R7=scalar(), which stays scalar across the cast and the inlined
check_mask() prologue, so the first dereference m->base (insn 94) is
rejected.

The same selftest was verified by Tejun on the for-7.3-fixes branch
(per the v3 cover letter, 20260919002838.1960071-1-tj, 16-CPU VM, three
standalone runs plus the full suite); the verifier-side arena handling
that changed during the 7.4 merge window appears to no longer accept
this pattern. The struct_ops argument path (direct __arena args, e.g.
ops.set_cmask) still works — only the u64-carried address form is
affected.

Reproducer (deterministic, two consecutive runs identical):

  # kernel: defconfig + SCHED_CLASS_EXT, DEBUG_INFO_BTF, FUNCTION_TRACER
  make O=build -j$(nproc)
  cd tools/testing/selftests/sched_ext
  make LLVM=1 O=$PWD/../../../../../build OUTPUT=out/ TEST_GEN_MODS_DIR=

  # initrd with out/runner + out/build + libs + busybox + kernel .config
  # at /boot/config-$(uname -r); then:
  qemu-system-x86_64 -enable-kvm -smp 4 -m 2G -nographic \
    -kernel build/arch/x86/boot/bzImage -initrd initrd.cpio.gz \
    -append "console=ttyS0"

  /root # ./runner -t enable_cmask
  not ok 1 enable_cmask #

Tested on:
  v7.4-rc2 (7475ea8b5):          FAIL  (verifier rejects at load)
  next-20261105 (gddfe51b0a0f5): FAIL  (same rejection)
  v7.3:                          SKIP  (struct scx_enable_args not present)

Compiler versions tried: clang 18 and clang 19 — identical bytecode
around the failing insn, identical rejection, so this does not look
compiler-dependent.

The other 40 tests in the suite pass on both 7.4-rc2 and next (after
enabling CONFIG_FUNCTION_TRACER, without which the fentry-based tests
maximal/kick_immediate/reload_loop fail with -EBUSY — worth a note in
the selftest docs, but that part is config, not a bug).

Possible directions (not investigated in depth):
  - a kfunc or verifier-supported way to convert the u64 carried in
    scx_enable_args into a PTR_TO_ARENA,
  - or an __arena-typed member/alias in scx_enable_args once BTF can
    express arena pointer members (the internal.h comment already
    anticipates this),
  - or adjusting the test to obtain the cmask through a path the
    verifier accepts.

Full verifier log and QEMU boot log available on request.

Signed-off-by: Zhijian Han <hanzhijian1991@gmail.com>
