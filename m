Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F5D3B0AFD
	for <sched-ext@lists.linux.dev>; Mon, 13 Apr 2026 15:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776095415; cv=none; b=cFMQQ7Wqef0lL9+q/GU+cIoazLHRdDrxMSVJCA/+twR6sxKzdJw3qbaaW8qjue2v1bqleYOY2X3mS8TdCG6vtTv0TdTlSs0kfbb7lUId+NURiBfdwvf9T88xZfe8bWfIcYeM1M5J63GeAQ2MuZh8QYlrYxWnI999C5a9+JvWvzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776095415; c=relaxed/simple;
	bh=YC685YyW6qw20jw9igIT2AdiNHEcGzlsq/ssz/jOiCQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=X4gG/PbBVHVzRf1m9+pbrgKNt7814AZkKcMbiDgfOJbOgV1w485oD/+wYVnhxewLxaz3/6eiQpt5N8B7n/0alTifBnOXjE1YootulfnHWjuncCjI1Bebjju1s5/A2Y6C6ree+f0bTeeGLRsbFqW/yOmk8+E4vfwH52filWPf7LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BThNVZkt; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BThNVZkt"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-43d1bfbd219so3325582f8f.0
        for <sched-ext@lists.linux.dev>; Mon, 13 Apr 2026 08:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776095413; x=1776700213; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dBKs6RmD5lklIwd+PqH307L7R0ZSIWZPtkNE1hSBlrw=;
        b=BThNVZktSTHHGejT+QwG2P8EiUdglV3V4bX5qbPCg2odSSkwCfMQxYnkOFv9GhHVRF
         9HUybdLP0lnsA96Bu3Vpk92KAeU54HMWnLpAdvCiBL+Da8nTX5fj25FUfL8o8DJzuF1f
         eGuB7Bed6RW3wpBRCUeIZu79DfaSwYhsJd5ZkjKoSqYenfoMN0MbISWrCQdaKVxaUF0F
         cSlon4wdNzr/pvKqZ1FCtX2qCfg1+bIUnPei7/1Y9rgzrV35c2LBGc/scS9/vdcDhaK3
         cJhAGVHIoVE7d+6c5Ss45PSsI8kLHTPOJZ/AW6CB2wuE//ayAmKSJP8SB488tAH9EB45
         i+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776095413; x=1776700213;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dBKs6RmD5lklIwd+PqH307L7R0ZSIWZPtkNE1hSBlrw=;
        b=h8r5IaPh5xmv1ZVjhUyRRluBY42dtoBQAjmCGLczFXwvi3ECJRhtcp+kR8IDpGFsJj
         eqQPqCpz88XgheSaAiWxafYGltMXG47lCVfF0qyUJKNwLPKRTX5M4SzYKEDVnwrHQgZF
         DFNcICoXA/YC2FjPwnklqhD62U0s63+AcZKp4pt1rTB3ESv+t6p60QnBFLplcLquqawa
         OSA5vOYYZxDD+PuegXlIrD3PAF/U2ZCtu5iXp9ncBWJ6Wnk/Q5FNOauwWM+IARevU8W1
         3TpJNHB8c3XZONRMCia1FAhPXxdibN18kIXxhMOxJGqrGm8yrYV6N6ses21egFfv1NJT
         XHRQ==
X-Forwarded-Encrypted: i=1; AFNElJ812BYJVYKDQHX3UNgOLPz/KD/3UUe4hhbfj/hRwfhkBnkjKGDm6W6N7jwC1E81Ztvz8xa8frd0DoA=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx3bs0Qe/XU48f7DAhN8iwz9sPAdSzKlxaK6mC3gkBE2EH/Wof1
	kZ9oyj0YwvN1+uuLEuNI7BHPqnqBATy3o4y6eViHQvyRY4mylCwZBVWrlwF9OQgIfjLP0YxodGy
	fPA9GQiBRAQPS1Q==
X-Received: from wrdf11.prod.google.com ([2002:a5d:58eb:0:b0:43d:7bb1:ac59])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2512:b0:43d:75ec:26f7 with SMTP id ffacd0b85a97d-43d75ec2939mr8089831f8f.29.1776095410379;
 Mon, 13 Apr 2026 08:50:10 -0700 (PDT)
Date: Mon, 13 Apr 2026 15:50:05 +0000
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260413155005.1215682-1-jpiecuch@google.com>
Subject: [PATCH sched_ext/for-7.1] tools/sched_ext: Add explicit cast from
 void* in RESIZE_ARRAY()
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
	David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev, 
	Kuba Piecuch <jpiecuch@google.com>
Content-Type: text/plain; charset="UTF-8"

This fixes the following compilation error when using the header from
C++ code:

  error: assigning to 'struct scx_flux__data_uei_dump *' from
  incompatible type 'void *'

Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
---
 tools/sched_ext/include/scx/common.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/sched_ext/include/scx/common.h b/tools/sched_ext/include/scx/common.h
index 823251fc47151..60f5513787d66 100644
--- a/tools/sched_ext/include/scx/common.h
+++ b/tools/sched_ext/include/scx/common.h
@@ -67,6 +67,7 @@ typedef int64_t s64;
 		bpf_map__set_value_size((__skel)->maps.elfsec##_##arr,			\
 				sizeof((__skel)->elfsec##_##arr->arr[0]) * (n));	\
 		(__skel)->elfsec##_##arr =						\
+			(typeof((__skel)->elfsec##_##arr))				\
 			bpf_map__initial_value((__skel)->maps.elfsec##_##arr, &__sz);	\
 	} while (0)
 
-- 
2.53.0.1213.gd9a14994de-goog

