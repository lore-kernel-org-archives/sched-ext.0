Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A782C2346
	for <sched-ext@lists.linux.dev>; Tue, 17 Feb 2026 07:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771313170; cv=none; b=Ithg0sJeMqxIkkb4DSN+ycsgG7F3dv8T3EtDDb/XzyFcjbJl5U12lQJ/HQSOfIINzQs0k1aJnThlR4ld2AEBYrlSykMlUC6BMpCzePi5Fjvo3V3t/kmVV8WGsvati8SqceXRT9SDsTtiLoV3W0IBFYqbeERBoSAkwIe6/MK+OME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771313170; c=relaxed/simple;
	bh=hgAJS3H8O4sPke0FMjqSU+7yyMWn17Mf4oo6TbxEyZU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Veg2wB39Ico2EB3LwKcHm/1Rk82WtvXy3aJVmI+WyE7flNknyM9uxBuPK1BxJ+DDpjT7MpwU3QzpotVJuG1TRw3n8QIdKmU8ahrfH7BdW6zklyZ3G8oQsahTUTPQWMQL3vtGIXs+Zoe0Kg690iSQNHu72zMGpia+vvamdIEu2TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nTxJpyJW; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTxJpyJW"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2aaecf9c325so27856885ad.1
        for <sched-ext@lists.linux.dev>; Mon, 16 Feb 2026 23:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771313168; x=1771917968; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ebhJpeMvZqswmtsOALYfT451ubkytiWutXAS4352MTM=;
        b=nTxJpyJWoHgd+JWljJHEJZdVvklG+FL4fAOXszwhXNTOHOKg8x9hGvHqoUkpjITsgo
         AOuTMOpOON396BNaghkATdUQXwO+0SC3Qt04jgF2s/5KN3vERF1zJV/o/kX6N25C0g1M
         YxfNbNC9NjubRFk708Q1gP0akBt6NNJY6eeggcHIWkYS5MGcSsuFgY0wDG7tfpc+po4N
         e9pGEOlX0D/CoTxAT2+gELqjSTMEkUXpjY95bLfCNFhmzVSWqMkqTgsIX9dE8TmIGNaD
         3KQsN42mh6YuueCTex81voGu4tTBaEpGexU4ZbPx8hclC/f8xcEkA4sQFFhtvAN+RCr3
         vg6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771313168; x=1771917968;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ebhJpeMvZqswmtsOALYfT451ubkytiWutXAS4352MTM=;
        b=fe9vznlfA3goov+r206B7x1jv5znaeOmsaO6flCiynzBYmB+5WOIpEcaC4CCwjaHXS
         oZQE0HRhOhq0YihVjvUfkb5VZmwNEBl9GDHw1OJbO/c3AelgU4BJ0ceHdsAWVFMkF07O
         2sO1LoHpkJoILsEz/tpuQLp86L85G7jRFl+fEc+AYHNTdOszv2k0YgLTLl31pwRNegLV
         jcGODIWEnnnbo8I+Aze2/+EwWpjdoGR/k4dAOy9z3Pp8hV+X5dYihIIKX+wZD2+qWpjh
         FCZ0KxluskFQmt6+j+JXUTgoypDqxE4i/zPRJClyt4BdNF0iYP49331BIURgTWI/SDqi
         4dZA==
X-Gm-Message-State: AOJu0YxKm+baHy7rEndwuR7hI3JEbk3pWmWvFRVps4S9YjJTrNPS1eLi
	2CyTrmBzjwmK3eFryoMoJ+4LNwiLBlS/rleWX51EgABjMrkWna1NzvQu3L618Q==
X-Gm-Gg: AZuq6aLCWT9H48E6+8ssa0PmC4w+n4+IoYYc04pOuaz4n43upA3gQqX3YIlu3SOou85
	/DqNUhOW9wziLsAA7Uvphx03x0f9x6T+MuJDxi5Vq/oRaSzvFX+JuiSSA4rp2EuW/6DrK4uS7Yu
	TCvEIYP13vfAknz7Bk1/Ai6wfo1xy8RYLRmBryF7LvEZ1gD3VkxdBU0cXjthlJz7y1w8df+XTHy
	TAaeN64D9V/iVGcvwuYBlBLRsxQXMcswR+wnxc23EqbwF0f/KCYbt2fIF+zn/i9IXfjwe7/9akq
	yFkOgZs+fS/atb5MZ9NYbwn9Hy1zO6w4rPwAhYGQ6f3bqpofElvjNndDPRdx8vZmsQimSiJN0uo
	7C+91RAFWOHc3VEhr74s2PtSuYBb8degMAl+Zo2jzWCihJFwJjVEPHDlHNqUu5jddTfTRpMiuiR
	9c4ub86fB6eY3IwgGUSMSFt9DywdnCo2BfrcjISV+nthDJy7rWbqdK
X-Received: by 2002:a17:903:22cc:b0:2aa:d327:beff with SMTP id d9443c01a7336-2ac9741f584mr126420155ad.6.1771313168042;
        Mon, 16 Feb 2026 23:26:08 -0800 (PST)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:3f49:4f7a:a0d9:2554])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1aaf4b31sm85528405ad.86.2026.02.16.23.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 23:26:07 -0800 (PST)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev
Cc: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH v2 0/2] tools/sched_ext: Sync configuration with upstream
Date: Tue, 17 Feb 2026 15:25:58 +0800
Message-ID: <20260217072600.953197-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series synchronizes the sched-ext tool's Kconfig and README.md
with the upstream scx repository.

Changes in v2:
- Rebase v1 to fix application failure.
- Remove duplicate Kconfig entries and non-user-selectable options.
- Refactor Kconfig comments for a more professional tone.
- Link to v1: https://lore.kernel.org/all/20260216110014.771335-1-yphbchou0911@gmail.com/

Thanks,
-chengyang

---

Cheng-Yang Chou (2):
  tools/sched_ext: Sync README.md Kconfig with upstream scx
  tools/sched_ext: Add Kconfig to sync with upstream

 tools/sched_ext/Kconfig   | 61 +++++++++++++++++++++++++++++++++++++++
 tools/sched_ext/README.md |  6 ----
 2 files changed, 61 insertions(+), 6 deletions(-)
 create mode 100644 tools/sched_ext/Kconfig

-- 
2.48.1

