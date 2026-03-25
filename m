Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3537374738
	for <sched-ext@lists.linux.dev>; Wed, 25 Mar 2026 07:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774424369; cv=none; b=ZkElEhlnTYxI1N07BrLFZQzi886U+tSBdDlwDTPY6mU5n59GIDDd7ezb5ak3qLUi5nXlxBk7sk8ISGJnYbEKfHdePYkLuxQFv7PIwZ7mJrNQ6BHXIySyXml46qqRlzQucY9eGLb1co0WSALu8qryWGWwPIu0+Nl++Q8USf917Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774424369; c=relaxed/simple;
	bh=lKZMysV6E0Sacu7KzOg8djmM5FEzj+xPf0Kt8gq4Utc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rap7W2W+a+nUXgnipHuphUc0N8OwZaB0n5l3id8WGeNhle9ZJnF7mWy5msGZl1aphyo9I5Y00iCjgqpM8hIO1QcEArjfHi+eFHdW6jT837OAxcJo1d1vu3hZqxdOV0ih0b3zVM0PQQCJ4VNuyfP1qs4BmUawNiQ0Ebx/lzwmd5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lp1EL3Aw; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lp1EL3Aw"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ab077e3f32so22074935ad.3
        for <sched-ext@lists.linux.dev>; Wed, 25 Mar 2026 00:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774424366; x=1775029166; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1gzTsrnfq3feyER8+ccqcmHdRTIBuzq8j4Hy1T3yuBc=;
        b=Lp1EL3AwYFO2qjKUmAsDbrwT9IZjJ9/Wr/sf1YQmFMLB8U/L13FwIwZh7cSpGUi3lt
         KgZ0qgRELyt8vLI9UKi6ySB6LMMJrfW/h9hkOBzCn/JCLarE3oH/NIIuNDXFC/nfG0js
         z8arE4+X7BQ98iJwpQA5FSDgwzE/NOWf+CWkGhGoQdWpkEoilsAxThlXOhC1rd7qYV7g
         WMzcoaQ6kjK5ynMO1SW6he0hVc9ansnnUs6kc+13aeG2RVg8VHHfvlrW0tdi//mtCl5C
         B0XWB5yYlXfhAaCHgcXTp5uuzhBiVxvho0gqt3oBhREgiUHFCvGzLfV3TJeQYBM/jWmH
         0trg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774424366; x=1775029166;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1gzTsrnfq3feyER8+ccqcmHdRTIBuzq8j4Hy1T3yuBc=;
        b=p0ER+gHQmO0n8KjPzfx9XB1hqpYI70/Ae6E4naI+wFv27BxuFQgnIawZlGoSkoQl+l
         v5f8xuaUrskLoFIc9+Zq4z4/kYFOCQtUj0ABByqiY1aP3QhVhO0fSgpLncLp0aZuO+gi
         GmJjFCd2OzJHjCH21qJs6m+KGtYWDBetewu0zTuU1Cqgp/X9nOBwfFqvdO+ErL0XbOTh
         IUfr0QestvR4mZI3+hIvIYI20Q9+hJz/E2uK8EZj4jeTFcWLOYmXsLdnePg0xo8xKP+r
         Y1zQ1rq4wpgaH/kvb5WA1raIXBFUPfC4VFMptTRXqdAcy2B7f1urGIcy9WdL3SVfwtuO
         y9Lg==
X-Gm-Message-State: AOJu0YxcXZy3SNpxkSr+ksiP6g7Ju7ZcvGBnYptjrCE58qUKT3eHyNUk
	wT7KbyUIqAJiQ2jRhYaWxZTJ7wNrHOY+ZcIuVXYDaff3QhS+fA/u61EI2WUEEA==
X-Gm-Gg: ATEYQzyJTtMLRO/XySJzs2GBQGhE9afBLdG9HiYb4LqDG7MX6VGJjZNyNJR/QoDzsDg
	NU9Kb9ILT2NiBXdxRyOjDZUzEZd9I+VlgOETQLLFoLawELRXu+qxyxJdwd3qbGZWzGgvHt1f4D2
	pZvrGg5K24vxwNlNFPxdTYdZDKFeqBcJhGc6UbdrE0g2dknHqNfKi0bbxLeo/MUjB5hS2hMjpp1
	QPBIA2MPAUN9+tobZrrE9ERL3YUiSHCa5XZjzLct1gVAD9XTUZZN352ErzYOHf2KEfu4sa0Oe0q
	QzJ9OZLngCSMSSQaZ6TXlo4rZTrECK7OE2fUaP+/o1B5LMf3eD8UEEd7AyRAq7NCYIDQ1c5DyQf
	hi73LXmx+L2RkLntA6xfkObq4j3oWyD9eFfe2DiMzklI2vYenHv18jfn4ByWb9VHQjL0aXy6AEf
	u103BVT2BrpzMszz2fabZbFwS+lt89IyjeHFk8J1lAmPriT5/+v3Fr9O1XE97MTyy82FRB39imq
	bfTNDtPl7IWEA==
X-Received: by 2002:a17:903:3c4e:b0:2aa:e3c7:6048 with SMTP id d9443c01a7336-2b0b0a42d45mr30125415ad.23.1774424365623;
        Wed, 25 Mar 2026 00:39:25 -0700 (PDT)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0b0129905sm22003445ad.27.2026.03.25.00.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 00:39:25 -0700 (PDT)
From: zhidao su <soolaugust@gmail.com>
X-Google-Original-From: zhidao su <suzhidao@xiaomi.com>
To: sched-ext@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	tj@kernel.org,
	arighi@nvidia.com
Subject: [DISCUSSION] SCX_OPS_ALWAYS_ENQ_IMMED semantics clarification
Date: Wed, 25 Mar 2026 15:39:20 +0800
Message-ID: <20260325073920.758426-1-suzhidao@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Tejun and all,

I'm working on understanding the sched_ext enqueue flow and noticed a
potential documentation gap regarding SCX_OPS_ALWAYS_ENQ_IMMED that I'd
like to clarify.

**Background:**

The flag comment in ext_internal.h L186-188 states:
  "If set, %SCX_ENQ_IMMED is assumed to be set on all local DSQ enqueues."

However, reviewing the implementation:
- The SCX_ENQ_IMMED injection happens only in scx_vet_enq_flags() L7812, 
  which is called exclusively from BPF kfunc paths 
  (scx_bpf_dsq_insert/scx_bpf_dsq_move_to_local).
- Kernel-side enqueues via do_enqueue_task() that take the `goto local` 
  path (L1883-1893) bypass scx_vet_enq_flags() entirely.

This means exiting and migration-disabled tasks using the kernel-side 
goto local path don't get SCX_ENQ_IMMED injected, and consequently 
don't get SCX_TASK_IMMED set in dsq_inc_nr().

The code comment at L1859-1862 acknowledges this:
  "exiting and migration-disabled tasks that skip ops.enqueue() below 
  will lose IMMED protection unless SCX_OPS_ENQ_EXITING / 
  SCX_OPS_ENQ_MIGRATION_DISABLED are set."

**Questions:**

1. Is this behavior intentional? Should "all local DSQ enqueues" in the 
   flag documentation be understood as "all BPF-path local DSQ enqueues"?

2. Should the flag documentation be updated to clarify this exception?

3. Or is the current behavior a gap that should be fixed by applying 
   ALWAYS_ENQ_IMMED semantics uniformly to kernel-side goto local paths 
   as well?

This would help clarify whether schedulers setting this flag can assume 
truly all local enqueues get IMMED protection, or only those through 
the BPF interface.

Thanks,
zhidao su
