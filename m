Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC3B5D8F0
	for <sched-ext@lists.linux.dev>; Mon,  2 Feb 2026 00:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769992950; cv=none; b=qHoLDdx4OgBNjDzh4BpJOdSH4kXxvswZSRjoe5D8v0yNkkY4kygE9Unwr1uwlVJJIz57sn56vZyRNnjs7x/mYeeTcI/d1yD79/I64GnnCNWFRoteuh+CUDv6aw9XTK5/KBdz9c00YuW/AQ+cyilSiqsZGgvODdoAfHLbBPtRRss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769992950; c=relaxed/simple;
	bh=/WBvdPd8hBYIETSBWpDWiWWl4w1wP7XZeLpc1/hmBoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bwjTdzIt5frJJFnBHp8r/1eRBtpHsGZdhgCaCUJJK9OrazlWaoNfXb7tfZ8u1hX7RdP9h7MmRvczepiWqEIR4QIE4YDTcyqCOO1TsfQWR/IWdslfDa9jnLaPgWDC8rjF9u3xOSMIQbF6UuZ5+f9NPJd1AZYKFX9TzvL6Jv3/kD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=p7UO88kC; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="p7UO88kC"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-89476eaaf16so38953246d6.1
        for <sched-ext@lists.linux.dev>; Sun, 01 Feb 2026 16:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1769992948; x=1770597748; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xCieT7l2N+boSMY9BGYtMHnU4hFmgRVpmso9DIlvUZA=;
        b=p7UO88kCE0AzA4w4eFRoIfUYUCNfb6+p0sIHsyiPLJHJJM4LHv149eAYR72cnQviWm
         5htKfwpS8U+lzHStbK8qCjzy8N8HlqjVAq8Wb1gpkY6PVPIMh3/u5KWz2gr2FN36JCA4
         wC2oems3IL43WRWhIVersKBN3wFvgQ1mDom1BudC/VSsjHZTuklh6pV/xkHBmRUjJnD8
         aStHrQ/9uuqz2JetYVV7Aw6/ZM2BWYV2LFJl8hIjEoJbz66XJDHbmygNi7OP3YdprFvE
         UwfG9gyYBLVLODLIqSLmy3P/4zGf93ZKp1Pq5s8avgtM7fqCR+E5DkaEMkMaS8ayTE3v
         tNIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769992948; x=1770597748;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xCieT7l2N+boSMY9BGYtMHnU4hFmgRVpmso9DIlvUZA=;
        b=h4v482NYUvQyY6XGOsKbxYSQ2nNjwLzGg2tr1kirHFJc/SPVfmxqzkJGt07076K+i/
         uE4LD7zEc/nQb8Li0JKV9MzykwxJgp0wzzoL1wz3ch2qpdUpZncwU7AN6mY8tKq+g4hP
         xVkOkEzszGqV0vzEt/auGSWlrmrFgU2qWM91aS1JjgQWvqLVA93l1pIpds0Dpkm3netI
         12AI57R55qfFoT0t7BW8ydx4tOyfFXltxL7ZYh6CfTExprOcp72/Fin6a5e/ICzCL2fn
         EQxYEP3uf1yMfGtIFexaSdzT2rpxtmH+XOlKqoE4e+EsXsJfxW8fT18/fQ+EQshpO5nP
         Vaog==
X-Gm-Message-State: AOJu0YyTOtVas0gLtGjDIzoO9Refua6vaDO0KY4LPNdYvEwjTz+0tJhO
	sdXO/V1Dn6U6zFZWfwB3JKi/S4+VuNQlI1iO8nJoTnpJ2YWTsPMKzf62tTxvH6RoOzpKNVi0EZ7
	mcWZa
X-Gm-Gg: AZuq6aIJ/xBSF4SdzQdtd8gc52QlBJMynpBZrEbKTqOTRooeBpIiXtbK2hYspDxX0Nk
	nBO6ja25TzuF+FvohevQgFAAte1xr/Gv77QoVR6VuKgCbVaJ8ZzN/xqKii7kUDoIx4Bl9r9zVjf
	9vBzuJITqNCf2z2DRQN0I8GfcKgRJ/r1yWWNJL1/2ulG8JnBGN7zhLYtufsqtyazdxFwz5bk5zy
	WdJY+3ka5q1iRVMWlW6B9AmivK8KhXANLFJZ7qfyfOLCJKYmFD++L4wY20i3hd7tL6PAmp5cY1r
	KieavN6l5cWb2VzjijgFW2PCf4Li9nXz5Y3hzBwQ1sHzKP/FZ8ealy6Ct8oKytS8mEw9vuh6OG5
	J/+r1YSkGfbYx92WvP+UMK7e7hZpoiZ4ViSaf5A1xCdwHD59kBNWcZ+FPY3H22Cg9/dscoKI3v9
	oKfwNqYJDRzA==
X-Received: by 2002:a05:6214:d6c:b0:894:6b62:b110 with SMTP id 6a1803df08f44-894e9f6d938mr145791006d6.17.1769992947840;
        Sun, 01 Feb 2026 16:42:27 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d36c4472sm104931006d6.17.2026.02.01.16.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 16:42:27 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: sched-ext@lists.linux.dev
Cc: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH] tools/sched_ext: Fix data header access during free in scx_sdt
Date: Sun,  1 Feb 2026 19:42:08 -0500
Message-ID: <20260202004208.42364-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a pointer arithmetic error in scx_sdt during freeing that
causes the allocator to use the wrong memory address for the
allocation's data header.

Fixes: f0262b102c7 ("tools/sched_ext: add scx_pair scheduler")
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 tools/sched_ext/scx_sdt.bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/sched_ext/scx_sdt.bpf.c b/tools/sched_ext/scx_sdt.bpf.c
index d965f7d209de..31b09958e8d5 100644
--- a/tools/sched_ext/scx_sdt.bpf.c
+++ b/tools/sched_ext/scx_sdt.bpf.c
@@ -312,7 +312,7 @@ int scx_alloc_free_idx(struct scx_allocator *alloc, __u64 idx)
 	pos = idx & mask;
 	data = chunk->data[pos];
 	if (likely(data)) {
-		data[pos] = (struct sdt_data) {
+		*data = (struct sdt_data) {
 			.tid.genn = data->tid.genn + 1,
 		};
 
-- 
2.49.0

