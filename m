Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C1A3BC69E
	for <sched-ext@lists.linux.dev>; Thu,  2 Apr 2026 11:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775131057; cv=none; b=sdrAxY6QknqM7Kt9jgJwsrq4IE7/lfQuPFVJ0W1XjbaDOuRG1QPOfx79e+oPd1hz7ucHkYUunWtv4dfvQKUV3ye4XIdKOuKyS/6otWQ7wpdVxheIq0EFWzGbl4kPY2Orzfik2owyE1/GQl4IKlIIw+TYRHItn3ODYuNvhk6RIZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775131057; c=relaxed/simple;
	bh=KhqRE7CFYOlplSPPnwwQ5/XtFDtRvB6slZCTyzApuwY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fNa46BB0vCRFlRJYjhnwBxn6ZnAwVohIH6ZdcomMLU5w91Tc5ccMsLEmKiCKLT9xDiwxcx93RJf/62mxtzbVP8d7HlL7tt80+t2kHjX184pr6RyFnyGFpYjPBulQVpWNzkZCW8DQ+C04I6iexr18zJU0NmzZZyqykp+y54IV/eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=TTrrktLx; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="TTrrktLx"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id E43F926561;
	Thu,  2 Apr 2026 13:57:29 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QZdZQ_BupTOv; Thu,  2 Apr 2026 13:57:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1775131049; bh=KhqRE7CFYOlplSPPnwwQ5/XtFDtRvB6slZCTyzApuwY=;
	h=From:To:Cc:Subject:Date;
	b=TTrrktLxxaYpHor2iqfy+F1ABjR8DCKjj/EzziNZcrJdF5a3kxCNfrwxYsHFB0fR7
	 vZ6a6WppMgKvsuygBdihfSNuM6Denvti2VX+kfzwqac2tjR0NyhFFKFDmVaaFv9Uc+
	 nr9ic0YvOa+Yw6fHc2eEpEv1y5GhnGUYB2jHYcikTIv24InJsFfv4bXCTOK5mxF49c
	 Nv/0kT10UqHkHz2oS3rsipjYNAwL9evdwHPQNzwsV1ZVNlRT4AH1KGfIRBBSLCKhzT
	 lXMOgy5OL4+RJRQKiCPdp/Ukr/CJtHwWHk3VF2OlprQ/cTVyNr3HlYFlZ8L2fLgkva
	 QgsOq9f4QY30Q==
From: Samuele Mariotti <smariotti@disroot.org>
To: arighi@nvidia.com,
	tj@kernel.org,
	void@manifault.com,
	changwoo@igalia.com
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Samuele Mariotti <smariotti@disroot.org>,
	Paolo Valente <paolo.valente@unimore.it>
Subject: [PATCH BUGFIX 1/1] sched_ext: Fix missing warning in scx_set_task_state() default case
Date: Thu,  2 Apr 2026 13:57:07 +0200
Message-ID: <20260402115707.1200476-1-smariotti@disroot.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In scx_set_task_state(), the default case was setting the
warn flag, but then returning immediately. This is problematic
because the only purpose of the warn flag is to trigger
WARN_ONCE, but the early return prevented it from ever firing,
leaving invalid task states undetected and untraced.

To fix this, a WARN_ONCE call is now added directly in the
default case.

The fix addresses two aspects:

 - Guarantees the invalid task states are properly logged
   and traced.

 - Provides a distinct warning message
   ("sched_ext: Invalid task state") specifically for
   states outside the defined scx_task_state enum values,
   making it easier to distinguish from other transition
   warnings.

This ensures proper detection and reporting of invalid states.

Signed-off-by: Samuele Mariotti <smariotti@disroot.org>
Signed-off-by: Paolo Valente <paolo.valente@unimore.it>
---
 kernel/sched/ext.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 1594987d637b..10683ce4e415 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2863,7 +2863,8 @@ static void scx_set_task_state(struct task_struct *p, enum scx_task_state state)
 		warn = prev_state != SCX_TASK_READY;
 		break;
 	default:
-		warn = true;
+		WARN_ONCE(1, "sched_ext: Invalid task state %d -> %d for %s[%d]",
+			  prev_state, state, p->comm, p->pid);
 		return;
 	}
 
-- 
2.47.3

