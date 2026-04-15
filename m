Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118831DDC37
	for <sched-ext@lists.linux.dev>; Wed, 15 Apr 2026 09:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776246900; cv=none; b=UCd1e9Pir6BfOUwQwpPwxv4kg8OSptFaJTjyYXYHyMAPMW/Q1aXebiTnLoizrdFpngIKkC+IMZ05+ftSNKfHcWe2kv/IXrwuYXh+o0shdQvK9gmOVbzdrzEFejQHAKhwqcuLAqZfL4PcH2t27r7s4kSHf2eXaF5OUwd+Kw/W/6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776246900; c=relaxed/simple;
	bh=dVtOEYW5GDZFqJjJms7bCaM4/q23W0OxIli888ughLU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PPmMS6EV5ri3CEVxKE8PaHAmvMqV6mmdrIDdshuYiMUKuMwjq5+j31GlrDIVblkyQyAfyWhcY9cFsIV3qhK1jDt1XOp3X6tO5lRFFtMOSMFZkgUvZstwhJ+W0wKw+anABqJ7FDM1xulLMPvcEtqKVSm4oB/P2MHaJDbq4comuyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=qI5hiBlb; arc=none smtp.client-ip=117.135.210.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="qI5hiBlb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=eU
	UewI/ZryNyGz5hmvXXOEYZRs/Bz1LcU1RMm7Vx4+Q=; b=qI5hiBlbXat0fhLFog
	mu0XFe7/Y/ZyHt+SvVktngU0QJOpHGRcQbMBQ7IVjSbw6ceJwYQKGCyg+t78HQnS
	gWL0F7uPqPOlnoJGwPBgRzWFXxe3WK69BrPTEHYHn1uEDh8Ay8gp/kWKMRKgdnK2
	zIkwaYsZ3PKmTiBezV/939rXM=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3n3ROYN9pPIBzBg--.58134S2;
	Wed, 15 Apr 2026 17:54:23 +0800 (CST)
From: Zhao Mengmeng <zhaomzhao@126.com>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhaomengmeng@kylinos.cn
Subject: [PATCH 0/2] sched_ext: Cgroup sub-scheduler minor fixes
Date: Wed, 15 Apr 2026 17:54:16 +0800
Message-ID: <20260415095418.307555-1-zhaomzhao@126.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3n3ROYN9pPIBzBg--.58134S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrAFWfCw45Gw4xCr4kuw4fuFg_yoWxGwcEva
	y5CFyUJFn0vFnrJa4agr45XrW8Ga1UXF95G3W2gFWUWr9xAr1DtF4UAay5ZF1jgFW7GF1r
	J3yFvFyrJwn7KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjS4i5UUUUU==
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/xtbBqw999GnfYE9wsAAA30

From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>

This patchset contains two fixes that I met when testing cgroup
sub-scheduler. Patch 1 add the -c option to scx_qmap help, which support
sub-scheduler but has no clue how to use it. Patch 2 add logs when sub-
scheduler is disabled, almost the same logic as root scheduler.

Zhao Mengmeng (2):
  tools/sched_ext: Add missing -c option in scx_qmap help
  sched_ext: Print sub-scheduler disabled log and reason

 kernel/sched/ext.c         | 39 +++++++++++++++++++++++---------------
 tools/sched_ext/scx_qmap.c |  1 +
 2 files changed, 25 insertions(+), 15 deletions(-)

-- 
2.43.0

